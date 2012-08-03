require "sprockets/directive_processor"

module Madride
  class DirectiveProcessor < Sprockets::DirectiveProcessor
    protected

    def process_layout_directive path
      context.layout = path
    end
  end
end
