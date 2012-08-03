require 'sprockets/context'


module Madride
  class Context < Sprockets::Context
    def self.locals
      @locals ||= {}
    end


    def locals
      self.class.locals
    end


    def layout= path
      depend_on_asset path
      @layout = path
    end


    def evaluate(path, options = {}, &block)
      pathname   = resolve(path)
      attributes = environment.attributes_for(pathname)
      processors = options[:processors] || attributes.processors

      if options[:data]
        result = options[:data]
      else
        if environment.respond_to?(:default_external_encoding)
          mime_type = environment.mime_types(pathname.extname)
          encoding  = environment.encoding_for_mime_type(mime_type)
          result    = Sprockets::Utils.read_unicode(pathname, encoding)
        else
          result = Sprockets::Utils.read_unicode(pathname)
        end
      end

      processors.each do |processor|
        begin
          template  = processor.new(pathname.to_s) { result }
          result    = template.render(self, locals){ options[:yield] }
        rescue Exception => e
          annotate_exception! e
          raise
        end
      end

      if @layout
        begin
          layout = self.class.new(environment, @layout, resolve(@layout))
          result = layout.evaluate(@layout, :yield => result)
        rescue Exception => e
          annotate_exception! e
          raise
        end
      end

      result
    end
  end
end
