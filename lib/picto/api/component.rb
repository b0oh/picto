require 'grape'

module Picto::Api
  class Component < Grape::API
    def self.inherited(subclass)
      super

      subclass.instance_eval do
        helpers SerializeHelpers

        format :json
        default_format :json

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({ error: { status: :invalid_param, message: e.message }}.to_json, 400)
        end

        rescue_from ActiveRecord::RecordNotFound do |_|
          rack_response({ error: { status: :not_found, message: 'not found' }}.to_json, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          rack_response({ error: { status: :unprocessable_entity, message: e.message }}.to_json, 422)
        end
      end
    end

    module SerializeHelpers
      extend Grape::API::Helpers

      def serialize(item, serializer)
        if item.respond_to?(:to_ary)
          ActiveModel::ArraySerializer.new(item, each_serializer: serializer).as_json
        else
          serializer.new(item).as_json
        end
      end
    end
  end
end
