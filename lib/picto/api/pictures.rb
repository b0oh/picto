require 'grape'

module Picto::Api
  class Pictures < Grape::API
    resources :pictures do
      get do
        {qwe: 1}
      end
    end
  end
end
