require 'grape'
require 'picto/api/pictures'

module Picto::Api
  class Root < Grape::API
    mount Picto::Api::Pictures
  end
end
