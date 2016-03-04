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
  spec.homepage      = "https://github.com/locumru/locum"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "pry", "~> 0.10"

  spec.add_runtime_dependency "highline", "~> 1.6"
  spec.add_runtime_dependency "thor", "~> 0.19"
  spec.add_runtime_dependency "json", "~> 1.8"
  spec.add_runtime_dependency "net-ssh", "~> 3.0"
end
