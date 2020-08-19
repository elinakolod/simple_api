# frozen_string_literal: true

require 'spec_helper'
require 'factory_bot'
require 'json_matchers/rspec'
require 'sidekiq/testing'
require 'simplecov'
require 'dox'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
SimpleCov.start
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec/docs/**/*.rb')].each { |f| require f }

Sidekiq::Testing.fake!

JsonMatchers.schema_root = 'spec/support/api/v1/schemas'

Dox.configure do |config|
  config.headers_whitelist = ['X-CSRF-Token']
  config.header_file_path = Rails.root.join('spec', 'docs', 'descriptions', 'header.md')
  config.desc_folder_path = Rails.root.join('spec', 'docs', 'descriptions')
end

RSpec.configure do |config|
  config.use_active_record = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.after(:each, :dox) do |example|
    example.metadata[:request] = request
    example.metadata[:response] = response
  end
end
