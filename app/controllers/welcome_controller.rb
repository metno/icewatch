class WelcomeController < ApplicationController
  respond_to :html, :json

  layout 'welcome'
  
  def index
    @cruise = Cruise.where(:id => params[:cruise][:_id]) if params[:id]
    @cruise ||= Cruise.asc(:start_date).first
    
    #@observations = Observation.where(:obs_datetime.lt => Date.parse("2010-1-1")).asc(:obs_datetime)
    
  end
  
end