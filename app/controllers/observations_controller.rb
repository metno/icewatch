require "rubypython"
class ObservationsController < ApplicationController
  before_action :set_observation, only: [:show, :edit, :update, :destroy]
  authorize_resource except: [:aspect]

  # GET /observations
  # GET /observations.json
  def index
    @cruise = Cruise.find(params[:cruise_id])
    @observations = @cruise.observations.order(observed_at: :desc).accessible_by(current_ability)
    
    
    
    respond_to do |format|
      format.csv { send_data build_csv, filename: "observations-#{@cruise.id}.csv"}
      format.json { send_data build_json, filename: "observations-#{@cruise.id}.json"}
      format.geojson { send_data build_geojson, filename: "observations-#{@cruise.id}.geojson"}
      format.sigrid3
    end
  end

  def aspect

    @cruise = Cruise.find(params[:id])
    @observations = @cruise.observations.order(observed_at: :desc).accessible_by(current_ability)
    
    RubyPython.start(:python_exe => "python2.7") # start the Python interpreter
    
    a2a =  RubyPython.import("a2a")
    
    assist = build_csv
    Rails.logger.info(assist)
    data = a2a.assist2aspect.str2str(assist)

    respond_to do |format|
      format.csv { send_data data, filename: "aspect-observations-#{@cruise.id}.csv"}
    end

    RubyPython.stop # stop the Python interpreter
    
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
  end

  # # GET /observations/new
  # def new
  #   @cruise = Cruise.find(params[:cruise_id])
  #   @observation = @cruise.build_observation
  # end

  # GET /observations/1/edit
  def edit
    @observation.valid?
    @observation.faunas.build
    @observation.photos.build
  end

  # POST /observations
  # POST /observations.json
  def create
    @cruise = Cruise.find(params[:cruise_id])
    @observation = @cruise.build_observation

    respond_to do |format|
      if @observation.save validate: false
        format.html { redirect_to edit_observation_path(@observation), notice: 'Observation was successfully created.' }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1
  # PATCH/PUT /observations/1.json
  def update
    @observation.assign_attributes observation_params
    @cruise = Cruise.find @observation.cruise_id
    respond_to do |format|
      if @observation.save(validate: false)
	if params[:commit] == 'Save and Exit'
          format.html { redirect_to cruise_url(@cruise), notice: 'Observation was successfully updated.' }
        else
          format.html { redirect_to edit_observation_path(@observation), notice: 'Observation was successfully updated.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    @cruise = Cruise.find params[:cruise_id]

    @csv_observation = CsvObservation.new(import_params)

    respond_to do |format|
      if @csv_observation.errors.any?
        format.json { render json: @csv_observation.errors.full_messages, status: :unprocessable_entity }
      else
        @observation = @csv_observation.build_observation
        @observation.cruise = @cruise
        if @observation.save validate: false
          format.html { redirect_to cruises_url, notice: 'Observations were successfully imported' }
          format.json { head :no_content }
          format.js
          AdminMailer.new_csv_upload(@observation)
        else
          format.html { redirect_to cruises_url, notice: 'There was an error importing the observations' }
          format.json { render json: @observation.errors.full_messages, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def import_follow_up
    # send mail after import is finised
    @cruise = Cruise.find params[:cruise_id]
    AdminMailer.new_csv_upload(@cruise).deliver
    render :nothing => true
  end

  def all
    @cruise = Cruise.find params[:cruise_id]

    @cruise.observations.destroy_all
    respond_to do |format|
      if assist?
        format.html { redirect_to root_url, notice: 'All observations were successfully destoyed.' }
      else
        format.html { redirect_to cruise_url(@cruise), notice: 'All observations were successfully destroyed.' }
      end
    end
  end

  def unapproved
    @cruise = Cruise.find params[:cruise_id]

    @cruise.observations.saved.destroy_all
    respond_to do |format|
      format.html { redirect_to cruise_url(@cruise), notice: 'All unapproved observations were successfully destroyed.' }
    end
  end

  def invalid
    @cruise = Cruise.find params[:cruise_id]
    @observations = @cruise.observations.reject(&:valid?)
    Observation.where(id: @observations).destroy_all

    respond_to do |format|
      format.html { redirect_to cruise_url(@cruise), notice: 'All unapproved observations were successfully destroyed.' }
    end
  end

  def approve
    @observation = Observation.find params[:id]

    if @observation.valid?
      @observation.accept!
    else
      flash[:error] = "Unable to approve an invalid observation"
    end

    redirect_to cruise_path(@observation.cruise)
  end

private

  def build_csv
    ## build csv observation file
    template = "<%= Observation.csv_headers %>
    <% @observations.each do |obs| %><%= obs.as_csv.to_csv.chomp.html_safe %>
    <% end %>
    "
    csv = ERB.new(template).result binding
  end
  
  def concentration_color(dominant_ice_type)
    case dominant_ice_type
    when 'old' then '#50BBD4'
    when 'new' then '#D9D9D9'
    when 'first_year' then '#BFD7D3'
    when 'other' then '#92A9C4'
    else '#FF0000'
    end
  end

  
  def build_geojson
    result = Jbuilder.new do |json|
      json.type 'FeatureCollection'
      json.features do
        json.array @observations do |observation|
          json.type 'Feature'
          json.geometry do
            json.type 'Point'
            json.coordinates [observation.longitude, observation.latitude]
          end
          json.properties do
            json.iceConcentration observation.ice.total_concentration
            json.fillColor concentration_color(observation.dominant_ice_type)
            json.dominantIceType observation.dominant_ice_type
          end
        end
      end
    end.attributes!
    JSON.generate(result)
  end 
  
  def build_json
    ## build json observation file
    result = Jbuilder.new do |json|
        json.extract! @cruise, :starts_at, :ends_at, :objective, :ship, :captain, :primary_observer, :chief_scientist
        json.observations do 
          json.array! @observations do |observation|
            json.extract! observation, :observed_at, :latitude, :longitude, :uuid
            json.primary_observer observation.primary_observer.try(:name)
            json.additional_observers observation.additional_observers.map(&:name)
            json.ice do
              json.extract! observation.ice, :open_water_lookup_code, :thick_ice_lookup_code,
                     :thin_ice_lookup_code, :total_concentration
            end
            json.ice_observations do
              json.array! observation.ice_observations do |ice_observation|
                  json.extract! ice_observation, :obs_type, :partial_concentration, :algae_density_lookup_code,
                              :algae_location_lookup_code, :algae_lookup_code, :floe_size_lookup_code,
                              :ice_lookup_code, :sediment_lookup_code, :snow_lookup_code, :snow_thickness,
                              :thickness
                  json.topography ice_observation.topography, :concentration, :ridge_height,
                                :consolidated, :old, :snow_covered, :topography_lookup_code
                  json.melt_pond ice_observation.melt_pond, :bottom_type_lookup_code, :dried_ice,
                               :freeboard, :max_depth_lookup_code, :pattern_lookup_code, :rotten_ice,
                               :surface_coverage, :surface_lookup_code
              end
            
            end
            json.meteorology do
              json.extract! observation.meteorology, :air_pressure, :air_temperature,
                            :relative_humidity, :total_cloud_cover, :visibility_lookup_code, :water_temperature,
                            :weather_lookup_code, :wind_direction, :wind_speed
              json.clouds do
                json.array! observation.meteorology.clouds do |cloud|
                    json.extract! cloud, :cloud_type, :cloud_lookup_code, :cover, :height
                end
              end
            end
            json.notes observation.notes.map(&:text)
            json.ship observation.ship, :heading, :power, :ship_activity_lookup_code, :speed
            json.comments do
              json.array! observation.comments do  |comment|
                json.extract! comment, :text
                json.person comment.person.try(&:name)
              end
            end
            json.photos do
              json.array! observation.photos do |photo|
                json.extract! photo, :on_boat_location_lookup_code, :note, :checksum
                json.name photo.file_filename
              end
            end
          end
        end
    end.attributes!
    JSON.generate(result)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_observation
    @observation = Observation.where(id: params[:id]).includes(:ice_observations).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def observation_params
    params.require(:observation).permit(
      :cruise_id, :observed_at, :latitude, :longitude, :uuid,
      :lat_minutes, :lat_seconds, :lon_minutes, :lon_seconds,
      :primary_observer_id_or_name, additional_observers_id_or_name: [],
                                    ship_attributes: [:id, :heading, :power, :speed, :ship_activity_lookup_id],
                                    notes_attributes: [:id, :text],
                                    ice_attributes: [:id, :total_concentration, :open_water_lookup_id,
                                                     :thick_ice_lookup_id, :thin_ice_lookup_id],
                                    ice_observations_attributes: [:id, :partial_concentration, :ice_lookup_id,
                                                                  :thickness, :floe_size_lookup_id, :snow_lookup_id, :snow_thickness,
                                                                  :algae_lookup_id, :algae_density_lookup_id, :algae_location_lookup_id,
                                                                  :sediment_lookup_id, :obs_type,
                                                                  topography_attributes: [:id, :concentration, :ridge_height, :consolidated,
                                                                                          :snow_covered, :old, :topography_lookup_id
                                                                                         ],
                                                                  melt_pond_attributes: [:id, :surface_coverage, :pattern_lookup_id,
                                                                                         :surface_lookup_id, :freeboard, :max_depth_lookup_id, :bottom_type_lookup_id,
                                                                                         :dried_ice, :rotten_ice
                                                                                        ]
                                                                 ],
                                    meteorology_attributes: [:id, :visibility_lookup_id, :weather_lookup_id,
                                                             :total_cloud_cover, :wind_speed, :wind_direction, :water_temperature,
                                                             :air_pressure, :air_temperature, :relative_humidity,
                                                             clouds_attributes: [:id, :cloud_lookup_id, :cover, :height, :cloud_type]
                                                            ],
                                    faunas_attributes: [:id, :name, :count, :_destroy],
                                    photos_attributes: [:id, :file, :on_boat_location_lookup_id, :_destroy]
    )
  end

  def import_params
    params.require(:observation).permit!
  end
end
