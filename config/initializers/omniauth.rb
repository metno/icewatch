#  require 'openid/store/filesystem'
require 'omniauth/strategies/keycloak-openid'

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :oktaoauth, ENV['OKTA_CLIENT_ID'], ENV['OKTA_CLIENT_SECRET'], {
      client_options: {
        site:          'https://login.met.no/auth/realms/External',
        authorize_url: 'https://login.met.no/auth/realms/External/protocol/openid-connect/auth',
        token_url:     'https://login.met.no/auth/realms/External/protocol/openid-connect/token'
      },
      #redirect_uri: 'http://157.249.151.243:3000/auth/oktaoauth/callback'
    }
    provider :keycloak_openid, 'Login.met.no', 'ice-watch-web-staging',
      client_options: {site: 'https://login.met.no', realm: 'External'}
  end
