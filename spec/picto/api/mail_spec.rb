require 'spec_helper'
require 'picto/api'
require 'picto/api/mail'

describe Picto::Api::Mail do
  include Rack::Test::Methods

  def app
    Picto::Api::Mail
  end

  describe 'POST /images/post' do
    describe 'validations' do
      describe 'one attachment' do
        before do
          path = File.join(Picto.root, 'spec', 'fixtures', 'chappie.jpg')
          file = Rack::Test::UploadedFile.new(path)
          post('/images/post', { 'sender' => 'email',
                                 'attachment-count' => '1',
                                 'attachment-1' => file })
        end

        it 'status' do
          expect(last_response.status).to eq(204)
        end

        it 'has no body' do
          expect(last_response.body).to be_empty
        end
      end

      describe 'not valid' do
        before do
          post('/images/post', 'qwe' => 'zxc')
        end

        let(:result) { ActiveSupport::JSON.decode(last_response.body) }

        it 'status' do
          expect(last_response.status).to eq(400)
        end

        it 'has bad request in result' do
          expect(result['error']['status']).to eq('invalid_param')
        end
      end

      describe 'less attachments than count' do
        it 'should throw exception' do
          expect {
            path = File.join(Picto.root, 'spec', 'fixtures', 'chappie.jpg')
            file = Rack::Test::UploadedFile.new(path)
            post('/images/post', { 'sender' => 'email',
                                   'attachment-count' => '2',
                                   'attachment-1' => file })
          }.to raise_error
        end
      end
    end

    describe 'workers' do
      it "shouldn't increse worker jobs" do
        expect {
          post('/images/post', 'sender' => 'email')
        }.to change(Picto::Worker::Image.jobs, :size).by(0)
      end

      it 'should increase worker jobs by 1' do
        expect {
          path = File.join(Picto.root, 'spec', 'fixtures', 'chappie.jpg')
          file = Rack::Test::UploadedFile.new(path)
          post('/images/post', { 'sender' => 'email',
                                 'attachment-count' => '1',
                                 'attachment-1' => file })
        }.to change(Picto::Worker::Image.jobs, :size).by(1)
      end

      it 'should increase worker jobs by 2' do
        expect {
          path = File.join(Picto.root, 'spec', 'fixtures', 'chappie.jpg')
          file = Rack::Test::UploadedFile.new(path)
          post('/images/post', { 'sender' => 'email',
                                 'attachment-count' => '2',
                                 'attachment-1' => file,
                                 'attachment-2' => file })
        }.to change(Picto::Worker::Image.jobs, :size).by(2)
      end
    end
  end
end
