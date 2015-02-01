require 'grape'

module Picto::Api
  class Mail < Grape::API
    resources :images do
      post :post  do
        sender = params[:sender]
        params['attachment-count'].to_i.times do |i|
          file = params["attachment-#{i+1}"][:tempfile]
          Sidekiq.redis { |c| c.set(file.path, file.read) }
          Picto::Worker::Image.perform_async(sender, file.path)
        end
        nil
      end
    end
  end
end
