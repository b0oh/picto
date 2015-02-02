require 'picto/api/component'

module Picto::Api
  class Mail < Component
    resources :images do
      desc 'Handle mail requests'
      params do
        requires 'sender',           type: String,  desc: 'email of a picture sender'
        requires 'attachment-count', type: Integer, default: 0
      end
      post :post  do
        sender = params[:sender]
        params['attachment-count'].times do |i|
          file = params["attachment-#{i+1}"][:tempfile]
          Sidekiq.redis { |c| c.set(file.path, file.read) }
          Picto::Worker::Image.perform_async(sender, file.path)
        end
        body false
      end
    end
  end
end
