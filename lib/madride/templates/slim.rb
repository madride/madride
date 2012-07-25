require "slim"


module Madride
  class SlimTemplate < Slim::Template
    class << self
      attr_reader :default_mime_type
      @default_mime_type = 'text/html'
    end
  end
end
