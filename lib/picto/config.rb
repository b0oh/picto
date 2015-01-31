require 'active_support/core_ext/string/inquiry'
require 'active_support/core_ext/module/delegation'
require 'settingslogic'

module Picto
  class << self
    def config
      Config
    end

    delegate :env, :root, to: :config
  end

  class Config < Settingslogic
    def self.root
      @root ||= File.expand_path('..', ENV['BUNDLE_GEMFILE'])
    end

    def self.config_path
      @config_path ||= File.join(root, 'config')
    end

    def self.env
      @env ||= (ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development').inquiry
    end

    def self.file
      @file ||= ENV['PICTO_CONFIG'] || File.join(config_path, 'config.yml')
    end

    private

    source file
    namespace env
  end
end
