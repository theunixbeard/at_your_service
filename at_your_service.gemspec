# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'at_your_service/version'

Gem::Specification.new do |spec|
  spec.name          = "at_your_service"
  spec.version       = AtYourService::VERSION
  spec.authors       = ["Ben Gelsey"]
  spec.email         = ["ben@bengelsey.com"]

  spec.summary       = %q{At Your Service --- Service Objects made easy (& works great w/ Rails)}
  spec.description   = %q{Model / View / Controller isn't enough for today's complex web applications. Encapsulate your business logic in Service objects so that when you write a piece of business logic, you only write it once.}
  spec.homepage      = "https://github.com/theunixbeard/at_your_service"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_dependency "virtus", "~> 1.0"
end
