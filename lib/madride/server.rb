require "rack"


module Madride
  class Server < Rack::Server
    def initialize(environment, options = {})
      @app = self.class.app environment
      super options
    end


    def self.app environment
      Rack::Builder.new do
        run environment
      end
    end
  end
end
