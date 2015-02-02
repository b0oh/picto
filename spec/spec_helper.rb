ENV['RACK_ENV'] = 'test'

require 'active_support'
require 'rack/test'
require 'database_cleaner'
require 'sidekiq/testing'
require 'picto'

CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
end

RSpec.configure do |c|
  c.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    Sidekiq::Worker.clear_all
    Sidekiq::Testing.fake!
  end

  c.around(:example) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
