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

RSpec::Core::RakeTask.new(:spec)

task default: :spec
task test: :spec
