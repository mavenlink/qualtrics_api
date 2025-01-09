# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'qualtrics_api/version'

Gem::Specification.new do |spec|
  spec.name          = "qualtrics_api"
  spec.version       = QualtricsAPI::VERSION
  spec.authors       = ["Yurui Zhang", "Marcin Naglik", "Mateusz Urbański"]
  spec.email         = ["yuruiology@gmail.com", "marcin.naglik@razorbear.com", "mateuszurbanski@yahoo.pl"]
  spec.summary       = %q{A Ruby wrapper for Qualtrics REST API v3.0}
  spec.description   = %q{A Ruby wrapper for Qualtrics REST API version 3.0.
                          See https://co1.qualtrics.com/APIDocs/ for API documents.}
  spec.homepage      = "https://github.com/CambridgeEducation/qualtrics_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0.6"

  spec.add_dependency "activesupport", "~> 6.1"
  spec.add_dependency "faraday", "~> 2"
  spec.add_dependency "faraday-follow_redirects", "~> 0.3"
  spec.add_dependency "faraday-multipart", "~> 1.1"
  spec.add_dependency "virtus", ">= 1.0"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "vcr", "~> 3.0"
end
