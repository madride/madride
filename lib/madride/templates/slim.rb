require "slim"


module Madride
  class SlimTemplate < Slim::Template
    self.default_mime_type = 'text/html'
  end
end
