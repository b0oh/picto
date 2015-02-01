require 'spec_helper'

describe Picto::UID do
  let(:user_id) { User.create(email: 'no').id }

  describe 'validates' do
    class ImageWithNoGen < ActiveRecord::Base
      include Picto::UID
      self.table_name = 'images'
    end

    it 'success' do
      image = ImageWithNoGen.new(user_id: user_id, uid: 'abcdef', file: 'file.png', width: 400, height: 300)
      expect(image.save).to eq(true)
    end

    it 'blank uid' do
      image = ImageWithNoGen.new(user_id: user_id, file: 'file.png', width: 400, height: 300)
      image.save
      expect(image.errors[:uid].length).to be > 0
    end

    it 'invalid uid' do
      image = ImageWithNoGen.new(user_id: user_id, uid: 'invalid uid', file: 'file.png', width: 400, height: 300)
      image.save
      expect(image.errors[:uid].length).to be > 0
    end
  end

  describe 'generation' do
    class ImageWithGen < ActiveRecord::Base
      include Picto::UID
      self.table_name = 'images'

      generate_uid do
        Picto::UID.plain_uid
      end
    end

    it 'success' do
      allow(Picto::UID).to receive(:plain_uid).with('abcdef') do
        image = ImageWithGen.new(user_id: user_id, file: 'file.png', width: 400, height: 300)
        image.valid?
        expect(image.uid).to eq('abcdef')
      end
    end

    it 'set uid manual' do
      image = ImageWithGen.new(user_id: user_id, uid: 'abcdef', file: 'file.png', width: 400, height: 300)
      image.valid?
      expect(image.uid).to eq('abcdef')
    end

    it 'exceed retries' do
      allow(Picto::UID).to receive(:plain_uid).with('abcdef') do
        ImageWithGen.create!(user_id: user_id, uid: 'abcdef', file: 'file.png', width: 400, height: 300)
        expect do
          ImageWithGen.create!(user_id: user_id, file: 'file.png', width: 400, height: 300)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
