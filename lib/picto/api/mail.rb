require 'grape'

module Picto::Api
  class Mail < Grape::API
    resources :images do
      post :post  do
        puts params
      end
    end
  end
end
