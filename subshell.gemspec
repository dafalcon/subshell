# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subshell/version'

Gem::Specification.new do |spec|
  spec.name          = 'subshell'
  spec.version       = Subshell::VERSION
  spec.authors       = ['Dan Falcone']
  spec.email         = ['danfalcone@gmail.com']

  spec.summary       = %q{Easily run subshell commands.}
  spec.description   = %q{Flexible library for running subshell commands with reasonable defaults.}
  spec.homepage      = 'https://github.com/falconed/subshell'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
