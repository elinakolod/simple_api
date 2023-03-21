# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'
gem 'active_model_serializers'
gem 'dry-validation'
gem 'fast_jsonapi'
gem 'jwt_sessions'
gem 'mongoid', '~> 7.0.5'
gem 'mongoid-rspec'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'puma', '~> 4.1'
gem 'pundit'
gem 'rails_best_practices'
gem 'redis'
gem 'reform-rails'
gem 'shrine', '~> 3.0'
gem 'shrine-mongoid', '~> 1.0'
gem 'sidekiq'
gem 'simple_endpoint', '~> 1.0.0'
gem 'streamio-ffmpeg'
gem 'trailblazer-rails'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner-mongoid'
  gem 'dox', require: false
  gem 'json_matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
