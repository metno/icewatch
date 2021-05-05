source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '= 4.2.9'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'therubyrhino', platforms: :jruby
gem 'version'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'warbler', '~> 2.0.0'#, platforms: :jruby
gem 'activerecord-jdbcsqlite3-adapter', platforms: :jruby
gem 'jruby-openssl', platforms: :jruby

gem 'pg','= 0.21.0', platforms: :ruby
gem 'puma', platforms: :ruby
gem 'chartkick'

gem 'haml'
gem 'omniauth'
#gem 'omniauth-github'
#gem 'omniauth-google-oauth2'
#gem 'omniauth-openid'
#gem 'google-api-client'
gem 'omniauth-oktaoauth'

gem 'friendly_id'
gem 'nested_form'
gem 'bootstrap_form', '= 2.7.0' #git: 'https://github.com/bootstrap-ruby/rails-bootstrap-forms.git'
gem 'cancancan'
gem 'rails_12factor', group: :production
gem 'httparty'
gem 'aasm'
gem 'rubyzip', '>= 1.0.0', require: 'zip'
gem 'whenever', platforms: :ruby
gem 'tzinfo-data'#, platforms: [:mingw, :mswin, :jruby]
gem 'high_voltage', '~> 2.2.1'#, platforms: :ruby
gem 'kaminari'
gem 'dotenv-rails'
gem 'refile', '~> 0.6.2', require: 'refile/rails'
gem 'refile-mini_magick', platforms: :ruby
gem 'active_link_to'
gem 'font-awesome-rails'
gem 'sidekiq', '< 5', platforms: :ruby

gem 'rubypython'#, '~> 0.6.4'

group :development, :test do
  gem 'better_errors', platforms: :ruby
  gem 'binding_of_caller', platforms: :ruby
  gem 'rubocop'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-rubocop'
  gem 'shoulda'
  gem 'capybara'
  gem 'poltergeist'
  gem 'forgery'
  gem 'pry-rails'
end


source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '3.3.7'
  gem 'rails-assets-eonasdan-bootstrap-datetimepicker'
  gem 'rails-assets-jasny-bootstrap', '3.1.3'
  gem 'rails-assets-selectize', '0.11.2'
  gem 'rails-assets-leaflet', '0.7.3'
  gem 'rails-assets-proj4'
  gem 'rails-assets-proj4leaflet', '0.7.2'
  gem 'rails-assets-papaparse', '4.0.7'
  gem 'rails-assets-moment' #, '2.8.4'
  gem 'rails-assets-highcharts', '4.1.10'
end

ruby '2.3.8'
