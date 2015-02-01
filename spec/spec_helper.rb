ENV['RACK_ENV'] = 'test'

require 'active_support'
require 'rack/test'
require 'database_cleaner'
require 'picto'

RSpec.configure do |c|
  c.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  c.around(:example) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
