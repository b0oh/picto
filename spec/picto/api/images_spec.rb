require 'spec_helper'
require 'picto/api'
require 'picto/api/images'

describe Picto::Api::Images do
  include Rack::Test::Methods

  def app
    Picto::Api::Images
  end

  describe 'GET /images' do
    before do
      get '/images'
    end

    let(:result) { ActiveSupport::JSON.decode(last_response.body) }

    it 'status' do
      expect(last_response.status).to eq(200)
    end

    it 'content-type' do
      expect(last_response.content_type).to eq('application/json')
    end

    it 'contains banners' do
      expect(result['images']).to be_instance_of(Array)
    end
  end
end
