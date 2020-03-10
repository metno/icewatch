ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
#require 'capybara/poltergeist'
'''
Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, js_errors: false)
end


Capybara.default_driver = :poltergeist#_debug
Capybara.javascript_driver = :poltergeist#_debug
Capybara.default_max_wait_time = 5
'''

Capybara.register_driver :selenium_chrome_headless do |app|
  # Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--window-size=1920,1080'
    opts.args << '--force-device-scale-factor=0.95'
    opts.args << '--headless'
    opts.args << '--disable-gpu'
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--no-sandbox'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.javascript_driver = :selenium_chrome_headless

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_user(user_id)
    user = users(user_id)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Add helper method to log in a user
  def login(user)
    u = users(user)
    visit('/auth/developer')
    fill_in('Name', with: u.name)
    fill_in('Email', with: u.email)
    click_button('Sign In')
  end

  def logout
    visit('/')

    click_on('Welcome', exact: false)
    click_link('Logout')
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

