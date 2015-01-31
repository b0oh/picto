require 'active_record'
require 'picto/config'

module Picto
  module Db
    class << self
      def connection
        ActiveRecord::Base.connection
      end

      def connect
        ActiveRecord::Base.default_timezone = :utc
        ActiveRecord::Base.configurations = Picto.config.db_configurations
        ActiveRecord::Base.establish_connection(Picto.env.to_sym)
      end

      def connected?
        ActiveRecord::Base.connected?
      end

      def disconnect
        ActiveRecord::Base.remove_connection
      end

      def configure_database_tasks
        tasks = ActiveRecord::Tasks::DatabaseTasks
        tasks.env = Picto.env
        tasks.root = Picto.root
        tasks.database_configuration = Picto.config.db_configurations
        tasks.migrations_paths = [File.join(Picto.config.db_path, 'migrate')]
        tasks.db_dir = Picto.config.db_path
      end
    end

    configure_database_tasks
  end
end
