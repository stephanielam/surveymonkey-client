# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'surveymonkey/client/version'

Gem::Specification.new do |spec|
  spec.name          = "surveymonkey-client"
  spec.version       = Surveymonkey::Client::VERSION
  spec.authors       = ["stephanielam"]
  spec.email         = ["stephanie@wishpond.com"]
  spec.summary       = %q{To be used with Chatty Panda}
  spec.description   = %q{To communicate with the Survey Monkey API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "sinatra"
end
