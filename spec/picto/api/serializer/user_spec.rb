require 'spec_helper'
require 'picto/api'
require 'picto/api/serializer/user'

describe Picto::Api::Serializer::User do
  let(:object) do
    user = User.new(email: 'email')
    user.id = 101
    user
  end

  subject { ActiveSupport::JSON.decode(described_class.new(object).to_json)['user'] }

  specify do
    expect(subject.keys).to eq(%w(id email))
  end
  specify { expect(subject).to include('id' => object.id) }
  specify { expect(subject).to include('email' => 'email') }
end
