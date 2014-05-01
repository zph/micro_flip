# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'micro_flip/version'

Gem::Specification.new do |spec|
  spec.name          = "micro_flip"
  spec.version       = MicroFlip::VERSION
  spec.authors       = ["Zander Hill"]
  spec.email         = ["Zander@civet.ws"]
  spec.summary       = %q{Feature flipping in < 50 lines of code (SLOC).}
  spec.description   = %q{Putting the µ back in micro flippers.}
  spec.homepage      = "http://github.com/zph/micro_flip"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "moneta"
  spec.add_dependency "sqlite3"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
