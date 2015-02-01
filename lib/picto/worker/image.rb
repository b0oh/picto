require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: Picto.config.redis.url, size: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: Picto.config.redis.url }
end

module Picto
  module Worker
    class Image
      include Sidekiq::Worker

      def perform(email, path)
        data = Sidekiq.redis { |c| c.get(path) }

        file = Tempfile.new(['', File.extname(path)])
        file.binmode
        file.write data
        file.rewind

        user = User.find_or_create_by!(email: email)
        user.images.create!(file: file)

        Sidekiq.redis { |c| c.del(path) }
      end
    end
  end
end
