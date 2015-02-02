require 'carrierwave'
require 'carrierwave/dropbox'
require 'mini_magick'
require 'picto/config'

CarrierWave.configure do |config|
  config.dropbox_app_key             = Picto.config.dropbox.app_key
  config.dropbox_app_secret          = Picto.config.dropbox.app_secret
  config.dropbox_access_token        = Picto.config.dropbox.access_token
  config.dropbox_access_token_secret = Picto.config.dropbox.access_token_secret
  config.dropbox_user_id             = Picto.config.dropbox.user_id
  config.dropbox_access_type         = 'dropbox'
  config.storage                     = :dropbox
end

class Picto::ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  WIDTH  = 400
  HEIGHT = 300

  BORDER_WIDTH = 10
  BORDER_COLORS = %w(yellow blue cyan orange brown gray)

  process convert: 'png'
  process resize_to_fill: [WIDTH - BORDER_WIDTH*2, HEIGHT - BORDER_WIDTH*2]
  process :borderize

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    'picto/images'
  end

  def filename
    "#{model.uid}.png"
  end

  def geometry
    @geometry ||=
      if file
        image = MiniMagick::Image.open(file.path)
        { width: image[:width], height: image[:height] }
      end
  end

  private

  def borderize
    manipulate! do |img|
      img.combine_options do |c|
        c.bordercolor BORDER_COLORS.sample
        c.border      BORDER_WIDTH
      end
      img
    end
  end
end
