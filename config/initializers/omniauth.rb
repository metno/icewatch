#  require 'openid/store/filesystem'
require 'omniauth/strategies/keycloak-openid'

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :oktaoauth, ENV['OKTA_CLIENT_ID'], ENV['OKTA_CLIENT_SECRET'], {
      client_options: {
        site:          'https://dev-471836.okta.com',
        authorize_url: 'https://dev-471836.okta.com/oauth2/v1/authorize',
        token_url:     'https://dev-471836.okta.com/oauth2/v1/token'
      },
    }
    provider :keycloak_openid, ENV['KEYCLOAK_CLIENT_ID'], 
      name: 'metlogin',
      client_options:  {
	site: 		ENV['KEYCLOAK_SERVER_URL'], #https://login.met.no', 
	realm: 		ENV['KEYCLOAK_REALM_NAME'] #'External'   
      }
    
end
