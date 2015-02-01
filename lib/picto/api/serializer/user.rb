require 'active_model_serializers'

module Picto::Api
  module Serializer
    class User < ActiveModel::Serializer
      attributes :id, :email
    end
  end
end
