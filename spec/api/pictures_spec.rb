require 'spec_helper'
require 'picto/api'
require 'picto/api/pictures'

describe Picto::Api::Pictures do
  include Rack::Test::Methods

  def app
    Picto::Api::Pictures
  end

  describe 'GET /pictures' do
    before do
      get '/pictures'
    end

    let(:result) { ActiveSupport::JSON.decode(last_response.body) }

    it 'status' do
      expect(last_response.status).to eq(200)
    end

    it 'content-type' do
      expect(last_response.content_type).to eq('application/json')
    end

    it 'contains banners' do
      expect(result['pictures']).to be_instance_of(Array)
    end
  end
end
