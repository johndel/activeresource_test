# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'vcr'
require 'webmock/rspec'

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    js_errors: false,
    debug: false,
    inspector: false,
    timeout: 180,
    phantomjs_options:
    [
      '--ignore-ssl-errors=yes'
    ]
  )
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

#configuration for VCR component
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.expose_current_running_example_as :example
  config.raise_errors_for_deprecations!
  config.infer_spec_type_from_file_location!

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.filter_run focus: true
  config.filter_run_excluding :slow unless ENV["SLOW_SPECS"]
  config.filter_run_excluding :setup unless ENV["SETUP_SPECS"]
  config.run_all_when_everything_filtered = true


  config.before(:all) do
    Capybara.current_driver = :poltergeist
    FactoryGirl.reload
  end

  config.after(:all) do
    Capybara.use_default_driver
  end

  config.before(:each) do
    Capybara.reset_sessions!
    Capybara.reset!
  end

  config.after(:each) do
  end

  # Add VCR to all tests
  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(/\./,'/').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '')
      VCR.use_cassette(name, options, &example)
    end
  end
end
