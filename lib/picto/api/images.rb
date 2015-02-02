require 'picto/api/component'
require 'picto/api/serializer/image'

module Picto::Api
  class Images < Component
    MAX_LIMIT = 100

    resources :images do
      desc 'Get all images'
      params do
        optional :limit,
                 type: Integer,
                 default: MAX_LIMIT,
                 desc: 'number of results to return per page'
        optional :offset,
                 type: Integer,
                 default: 0,
                 desc: 'skip number of results from beginning'
      end
      get  do
        scope  = Image.includes(:user).order('created_at DESC')
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
    end
  end
end
