require 'grape'

module Picto::Api
  class Pictures < Grape::API
    format :json

    resources :pictures do
      get do
        {pictures: []}
      end
    end
  end
end
