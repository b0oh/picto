#!/usr/bin/env rake
require 'bundler/setup'
require 'rspec/core/rake_task'

desc 'Open a pry session preloaded with this app'
task :console do
  exec 'bundle exec pry -rpicto -rpicto/api'
end
task c: :console

RSpec::Core::RakeTask.new(:spec)

task default: :spec
task test: :spec
