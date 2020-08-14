# frozen_string_literal: true

require 'spec_helper'
require 'factory_bot'
require 'sidekiq/testing'
require 'json_matchers/rspec'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

Sidekiq::Testing.fake!

JsonMatchers.schema_root = 'spec/support/api/v1/schemas'

RSpec.configure do |config|
  config.use_active_record = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
