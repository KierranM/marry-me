# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marry/me/version'

Gem::Specification.new do |spec|
  spec.name          = 'marry-me'
  spec.version       = Marry::Me::VERSION
  spec.authors       = ['Kierran McPherson']
  spec.email         = ['kierranm@gmail.com']
  spec.licenses      = ['MIT', 'GPL-2']

  spec.summary       = 'A small lib for pairing groups of things'
  spec.description   = 'Matches groups of things using variations of the stable marriage algorithm'
  spec.homepage      = 'https://github.com/KierranM/marry-me'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.has_rdoc      = 'yard'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
end
