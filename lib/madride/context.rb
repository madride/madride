require 'sprockets/context'


module Madride
  class Context < Sprockets::Context
    def self.locals
      @locals ||= {}
    end


    def evaluate(path, options = {})
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
          template = processor.new(pathname.to_s) { result }
          result = template.render(self, self.class.locals)
        rescue Exception => e
          annotate_exception! e
          raise
        end
      end

      result
    end
  end
end
