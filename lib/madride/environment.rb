require "sprockets"


require "madride/templates/slim"
require "madride/context_patch"


module Madride
  class Environment < Sprockets::Environment
    def initialize *args
      super

      register_engine '.slim', SlimTemplate

      Madride.paths.each do |path|
        append_path path
      end


      @context_class.send(:include, ContextPatch)
    end


    def locals
      @context_class.locals
    end
  end
end
