# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'locum/version'

Gem::Specification.new do |spec|
  spec.name          = "locum"
  spec.version       = Locum::VERSION
  spec.authors       = ["Vasily Shmelev"]
  spec.email         = ["sleephunter@gmail.com"]
  spec.summary       = %q{Locum.ru maintenance interface}
#  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://locum.ru"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "highline"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "json"
end
