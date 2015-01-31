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
    class << self
      def root
        @root ||= File.expand_path('..', ENV['BUNDLE_GEMFILE'])
      end

      def config_path
        @config_path ||= File.join(root, 'config')
      end

      def db_path
        @config_path ||= File.join(root, 'db')
      end

      def env
        @env ||= (ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development').inquiry
      end

      def file
        @file ||= ENV['PICTO_CONFIG'] || File.join(config_path, 'config.yml')
      end

      def db_configurations
        { env => self.db }
      end
    end

    private

    source file
    namespace env
  end
end
