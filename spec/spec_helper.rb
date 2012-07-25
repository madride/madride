# stdlib
require 'pathname'

# 3rd-party
require 'rack/test'

# internal
require_relative '../lib/madride'


module Madride
  module RSpec
    module Helpers
      extend self


      def fixtures_root
        @fixtures_root ||= Pathname.new(__FILE__).parent.join('fixtures')
      end


      def fixtures_path path
        fixtures_root.join(path.to_s)
      end
    end
  end
end


RSpec.configure do |config|
  config.include Madride::RSpec::Helpers
end
