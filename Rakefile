#!/usr/bin/env rake
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'picto/config'
require 'picto/db'

task(:environment) do
  ActiveRecord::Base.configurations = Picto.config.db_configurations
  ActiveRecord::Base.establish_connection(Picto.env.to_sym)
end

load 'active_record/railties/databases.rake'
load 'carrierwave/dropbox/authorize.rake'

desc 'Open a pry session preloaded with this app'
task :console do
  exec 'bundle exec pry -rpicto -rpicto/api'
end
task c: :console

desc 'Pings PING_URL to keep a dyno alive'
task :dyno_ping do
  require "net/http"

  if ENV['PING_URL']
    uri = URI(ENV['PING_URL'])
    Net::HTTP.get_response(uri)
  end
end

desc 'Cache urls'
task :cache_urls do
  require 'picto'

  Image.find_each { |i| i.send :cache_url }
end

desc 'Heroku tasks'
task heroku: [:dyno_ping, :cache_urls]

RSpec::Core::RakeTask.new(:spec)

task default: :spec
task test: :spec
