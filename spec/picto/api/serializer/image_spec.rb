require 'spec_helper'
require 'picto/api'
require 'picto/api/serializer/image'

describe Picto::Api::Serializer::Image do
  let(:object) do

    user = User.new(email: 'email')
    user.id = 101

    file = Object.new
    allow(file).to receive(:url).and_return '/url'
    image = Image.new(user: user,
                      width: 400,
                      height: 300)
    expect(image).to receive(:file).and_return(file).at_least(:once)
    image.uid = SecureRandom.uuid
    image
  end

  subject { ActiveSupport::JSON.decode(described_class.new(object).to_json)['image'] }

  specify do
    expect(subject.keys).to eq(%w(id url width height user))
  end
  specify { expect(subject).to include('id'     => object.uid) }
  specify { expect(subject).to include('width'  => object.width) }
  specify { expect(subject).to include('height' => object.height) }
  specify { expect(subject).to include('url'    => '/url') }
  specify { expect(subject).to include('user') }
end
