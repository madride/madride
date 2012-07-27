require "sprockets"
require "madride/templates/slim"


module Madride
  class Environment < Sprockets::Environment
    def initialize *args
      super

      register_engine '.slim', SlimTemplate

      Madride.paths.each do |path|
        append_path path
      end
    end
  end
end
