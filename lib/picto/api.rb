require 'forwardable'
require 'sidekiq/web'
require 'picto'
require 'picto/api/root'

module Picto::Api
    # Main rack application where all endpoints should be mounted
  class Routes
    def initialize
      @app = Rack::Builder.new do
        use Rack::Static,
            urls: %w(/build /css),
            root: File.join(Picto.root, 'client')

        map('/api') { run Picto::Api::Root }
        map('/sidekiq') { run Sidekiq::Web }
        map('/') do
          run(lambda do |env|
                [ 200,
                  { 'Content-Type'  => 'text/html',
                    'Cache-Control' => 'public, max-age=86400'
                  },
                  File.open(File.join(Picto.root, 'client', 'index.html'), File::RDONLY)
                ]
              end)
        end
      end
    end

    def call(env)
      @app.call(env)
    end
  end

  extend SingleForwardable

  # @!method new
  #  Proxies call of #new to +Routes+. Gives possibility to start application
  #  through `run ManagementAPI.new`
  #  @return [ManagementAPI::Routes] return +Routes+ rack application instance
  def_single_delegators Routes, :new
end
