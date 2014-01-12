# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'grape-hal'
  spec.version       = '0.0.1'
  spec.authors       = ['Feng Zhichao']
  spec.email         = %w(flankerfc@gmail.com)
  spec.description   = %q{Provides the HAL response for Grape API application}
  spec.summary       = %q{HAL support for your Grape app}
  spec.homepage      = 'https://github.com/flanker/grape-hal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0.4'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-debugger'

  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'grape'
end
