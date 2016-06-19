# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repos/version'

Gem::Specification.new do |spec|
  spec.name          = 'repos'
  spec.version       = Repos::VERSION
  spec.authors       = ['Nicolas McCurdy']
  spec.email         = ['thenickperson@gmail.com']

  spec.summary       = 'A tool for finding git repositories locally.'
  spec.homepage      = 'https://github.com/nicolasmccurdy/repos'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 11'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
