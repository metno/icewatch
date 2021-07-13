class ApplicationController < ActionController::Base
  include GinaAuthentication::AppHelpers

  before_action :set_variant_type
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Use keycloak Client Credentials Grant for POSTS requests to json endpoints 
  skip_before_filter :verify_authenticity_token, except: [:show, :index], if: :json_request?
  before_action :authenticate_request, except: [:show, :index], if: :json_request?

  def set_variant_type
    request.variant = :assist if Rails.application.secrets.icewatch_assist
    request.variant = :assist if RUBY_PLATFORM == 'java'
  end

  rescue_from CanCan::AccessDenied do |exception|
    session[:redirect_back_to] = request.original_url
    redirect_to root_url
  end

  def assist?
    # Shows up as an array. Not sure if that is always the case so
    #  force it to be one for this check
    Array(request.variant).include? :assist
  end

  def json_request?
    request.format.json?
  end

  def authenticate_request
    authorise = AuthorizeApiRequest.call(request.headers)
    if authorise.success?
      @current_user = authorise.result
    else
      render json: { error: 'Not Authorized', reason: authorise.errors }, status: 401
    end
  end
end
