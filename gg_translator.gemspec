# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gg_translator/version'

Gem::Specification.new do |spec|
  spec.name          = "gg_translator"
  spec.version       = GgTranslator::VERSION
  spec.authors       = ["Serge Kislak"]
  spec.email         = ["kislak7@gmail.com"]
  spec.description   = %q{commandline repl translator}
  spec.summary       = %q{run: gg}
  spec.homepage      = "http://github.com/kislak/gg_translator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
