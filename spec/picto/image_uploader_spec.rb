require 'spec_helper'
require 'carrierwave/test/matchers'

describe Picto::ImageUploader do
  include CarrierWave::Test::Matchers

  before do
     Picto::ImageUploader.enable_processing = true
    image = Image.new uid: 'abcdef'
    @uploader = Picto::ImageUploader.new(image, :file)
    @uploader.store!(File.open(File.join(Picto.root, 'spec', 'fixtures', 'chappie.jpg')))
  end

  after do
     Picto::ImageUploader.enable_processing = false
    @uploader.remove!
  end

  it "should scale down a image to be exactly #{Picto::ImageUploader::WIDTH} by #{Picto::ImageUploader::HEIGHT} pixels" do
    expect(@uploader).to have_dimensions(Picto::ImageUploader::WIDTH, Picto::ImageUploader::HEIGHT)
  end
end
