# -*- encoding: utf-8 -*-
require File.expand_path('../lib/madride/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "madride"
  gem.version       = Madride::VERSION
  gem.homepage      = ""
  gem.authors       = ["Aleksey V Zapparov"]
  gem.email         = ["ixti@member.fsf.org"]
  gem.summary       = "madride-#{Madride::VERSION}"
  gem.description   = %q{Zero-configuration command-line HTTP server.}

  gem.add_dependency "sprockets", "~> 2.4"
  gem.add_dependency "rack", "~> 1.0"
  gem.add_dependency "slim", "~> 1.2"

  gem.add_development_dependency "rake", "~> 0.9"
  gem.add_development_dependency "rspec", "~> 2.11"
  gem.add_development_dependency "rack-test", "~> 0.6"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ["lib"]
end
