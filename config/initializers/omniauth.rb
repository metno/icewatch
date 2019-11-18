#  require 'openid/store/filesystem'

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :oktaoauth, ENV['OKTA_CLIENT_ID'], ENV['OKTA_CLIENT_SECRET'], {
      client_options: {
        site:          'https://dev-471836.okta.com',
        authorize_url: 'https://dev-471836.okta.com/oauth2/v1/authorize',
        token_url:     'https://dev-471836.okta.com/oauth2/v1/token'
      },
      #redirect_uri: 'http://157.249.151.243:3000/auth/oktaoauth/callback'
    }
  end
