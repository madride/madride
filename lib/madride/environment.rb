require "sprockets"
require "tilt/haml"


require "madride/templates/slim"
require "madride/context"
require "madride/directive_processor"


module Madride
  class Environment < Sprockets::Environment
    def initialize *args
      super

      @context_class = Class.new(Context)

      # unregister .htm and register .html instead
      register_mime_type nil, '.htm'
      register_mime_type 'text/html', '.html'

      register_engine '.slim', SlimTemplate
      register_engine '.haml', Tilt::HamlTemplate

      register_preprocessor 'text/html', DirectiveProcessor

      Madride.paths.each do |path|
        append_path path
      end
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
