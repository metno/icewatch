#  require 'openid/store/filesystem'
require 'omniauth/strategies/keycloak-openid'

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :keycloak_openid, ENV['KEYCLOAK_CLIENT_ID'], 
      name: 'metlogin',
      client_options:  {
	site: 		ENV['KEYCLOAK_SERVER_URL'], #https://login.met.no', 
	realm: 		ENV['KEYCLOAK_REALM_NAME'] #'External'   
      }
    
end
