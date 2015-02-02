require 'picto/api/component'

module Picto::Api
  class Config < Component
    resource :config do
      get do
        { config: { mail: Picto.config.mail_to_send } }
      end
    end
  end
end
