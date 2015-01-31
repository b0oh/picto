class Image < ActiveRecord::Base
  belongs_to :user
  validates :file, :width, :height, presence: true
end
