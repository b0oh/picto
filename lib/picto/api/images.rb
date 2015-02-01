require 'grape'
require 'picto/api/serializer/image'

module Picto::Api
  class Images < Grape::API
    MAX_LIMIT = 100

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      rack_response({ error: { status: :invalid_param, message: e.message }}.to_json, 400)
    end

    rescue_from ActiveRecord::RecordNotFound do |_|
      rack_response({ error: { status: :not_found, message: 'not found' }}.to_json, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      rack_response({ error: { status: :unprocessable_entity, message: e.message }}.to_json, 422)
    end

    helpers do
      params :user_params do
        requires :user, type: Hash do
          requires :email, type: String
        end
      end

      params :image_params do
        requires :image, type: Hash do
          requires :file, type: Rack::Multipart::UploadedFile
        end
      end

      def user_params
        declared(params, include_missing: false)[:user]
      end

      def image_params
        res = declared(params, include_missing: false)[:image]
        res[:file] = res[:file][:tempfile]
        res
      end

      def serialize(item, serializer)
        if item.respond_to?(:to_ary)
          ActiveModel::ArraySerializer.new(item, each_serializer: serializer).as_json
        else
          serializer.new(item).as_json
        end
      end
    end

    format :json

    resources :images do
      desc 'Get all images'
      params do
        optional :limit,
                 type: Integer,
                 default: MAX_LIMIT,
                 desc: 'limit the number of results by this number'
        optional :offset,
                 type: Integer,
                 default: 0,
                 desc: 'skip this number of results from result set beginning'
      end
      get  do
        scope  = Image.includes(:user)
        total  = scope.count
        limit  = params[:limit] > MAX_LIMIT ? MAX_LIMIT : params[:limit]
        offset = params[:offset]
        images = scope.limit(limit).offset(offset)

        { images: serialize(images, Serializer::Image),
          pagination: {
            total: total,
            count: images.size,
            limit: limit,
            offset: offset
          }
        }
      end

      desc 'Create image'
      params do
        use :user_params
        use :image_params
      end
      post do
        user = User.find_or_create_by!(user_params)
        image = user.images.create!(image_params)
        serialize(image, Serializer::Image)
      end
    end
  end
end
