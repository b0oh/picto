require 'carrierwave'
require 'mini_magick'

class Picto::ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  WIDTH  = 400
  HEIGHT = 300

  process convert: 'png'
  process resize_to_fill: [WIDTH, HEIGHT]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end

  def geometry
    @geometry ||=
      if file
        image = MiniMagick::Image.open(file.path)
        { width: image[:width], height: image[:height] }
      end
  end
end
