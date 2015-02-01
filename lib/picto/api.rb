require 'forwardable'
require 'sidekiq/web'
require 'picto'
require 'picto/api/root'

module Picto::Api
    # Main rack application where all endpoints should be mounted
  class Routes
    def initialize
      @app = Rack::Builder.new do
        map('/api') { run Picto::Api::Root }
        map('/sidekiq') { run Sidekiq::Web }
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
