class User < ActiveRecord::Base
  has_many :images
  validates :email, presence: true
end
