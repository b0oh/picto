require 'grape'
require 'picto/api/images'
require 'picto/api/mail'

module Picto::Api
  class Root < Grape::API
    mount Picto::Api::Images
    mount Picto::Api::Mail
  end
end
