class PhotosController < ApplicationController
  before_action :set_parent

  def show
    @photo = Photo.find(params[:id])
    full_path = Refile.store.get(@photo.file_id).download 

    respond_to do |format|
      format.any { send_file full_path, type: request.format, disposition: 'inline' }
    end
  end

  def index
    @photos = @parent.photos.page(params[:page]).per(25)
  end

  def download
    @photo = Photo.find(params[:photo_id])
    send_file Refile.store.get(@photo.file_id).download
  end

  private
  def set_parent
    @cruise = @parent = Cruise.find(params[:cruise_id]) if params[:cruise_id]

    if params[:observation_id]
      @parent = Observation.find(params[:observation_id])
      @cruise = @parent.cruise
    end
  end
end
