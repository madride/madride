require "sprockets"
require "tilt/haml"


require "madride/templates/slim"
require "madride/context_patch"


module Madride
  class Environment < Sprockets::Environment
    def initialize *args
      super

      register_engine '.slim', SlimTemplate
      register_engine '.haml', Tilt::HamlTemplate

      Madride.paths.each do |path|
        append_path path
      end


      @context_class.send(:include, ContextPatch)
    end


    def locals
      @context_class.locals
    end


    def call env
      env['PATH_INFO'] += '.html' if File.extname(unescape(env['PATH_INFO'].to_s)).empty?
      super
    end
  end
end
