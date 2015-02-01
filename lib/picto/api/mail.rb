require 'grape'

module Picto::Api
  class Mail < Grape::API
    resources :images do
      post :post  do
        user = User.find_or_create_by!(email: params[:sender])
        params['attachment-count'].to_i.times do |i|
          attachment = params["attachment-#{i+1}"]
          user.images.create!(file: attachment.tempfile)
        end
        nil
      end
    end
  end
end
