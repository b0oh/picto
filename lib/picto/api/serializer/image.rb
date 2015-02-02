require 'active_model_serializers'
require 'picto/api/serializer/user'

module Picto::Api
  module Serializer
    class Image < ActiveModel::Serializer
      attributes :id, :url, :width, :height, :user

      def id
        object.uid
      end

      def url
        object.cached_url
      end

      def user
        User.new(object.user, root: false)
      end
    end
  end
end
