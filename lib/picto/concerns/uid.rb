require 'active_support/concern'

module Picto::UID
  extend ActiveSupport::Concern

  MAX_RETRIES = 5
  REGEX = /\A[0-9a-z\-_]+\z/i

  included do
    validates :uid, presence: true, uniqueness: true, format: { with: REGEX }
  end

  module ClassMethods
    def generate_uid(&block)
      before_validation do
        unless uid
          generated_uid = instance_eval(&block)
          MAX_RETRIES.times do
            break unless self.class.where(uid: generated_uid).exists?
            generated_uid = instance_eval(&block)
          end
          self.uid = generated_uid
        end
      end
    end
  end

  def self.plain_uid
    SecureRandom.hex(16)
  end
end
