require 'carrierwave/orm/activerecord'

class Image < ActiveRecord::Base
  include Picto::UID

  generate_uid { Picto::UID.plain_uid }

  belongs_to :user

  mount_uploader :file, Picto::ImageUploader

  before_validation :update_dimensions

  validates :file, :width, :height, presence: true

  private

  def update_dimensions
    if file_changed? && !dimensions_set_manually?
      self.width  = file.geometry[:width]
      self.height = file.geometry[:height]
    end
  end

  def dimensions_set_manually?
    width_changed? && height_changed?
  end
end
