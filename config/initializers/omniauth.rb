  require 'openid/store/filesystem'

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :oktaoauth, ENV['OKTA_CLIENT_ID'], ENV['OKTA_CLIENT_SECRET'], {
      client_options: {
        site:          'https://dev-553292.okta.com',
        authorize_url: 'https://dev-553292.okta.com/oauth2/v1/authorize',
        token_url:     'https://dev-553292.okta.com/oauth2/v1/token'
      },
      #redirect_uri: 'http://157.249.151.243:3000/auth/oktaoauth/callback'
    }
    # provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"], {
    #   name: "google",
    #   scope: "userinfo.email, userinfo.profile",
    #   image_aspect_ratio: "square",
    #   image_size: 50# ,
    #   prompt: 'consent'
    # }
    # provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'gina', :identifier => 'https://id.gina.alaska.edu'
    provider :google_oauth2, Rails.application.secrets.google_key, Rails.application.secrets.google_secret, {
      name: 'google',
      scope: 'userinfo.profile,userinfo.email',
      # leave this out for now for dev purposes
      # hd: "alaska.edu",
      include_granted_scopes: true,
      # scope: "userinfo.profile",
      #image_aspect_ratio: "square",
      #image_size: 50,
      # prompt: 'select_account'
    }
  end
