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

      # text/html extension is .htm, so we need to reassign aliases map manually

      @trail.alias_extension '.slim', '.html'
      @trail.alias_extension '.haml', '.html'
      @trail.alias_extension '.htm',  '.html'

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


    private


    def headers env, asset, length
      super(env, asset, length).tap do |headers|
        headers["Content-Type"] << ";charset=utf8" if "text/html" == asset.content_type
      end
    end
  end
end
