# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bosh_release_resource/version'

Gem::Specification.new do |spec|
  spec.name          = 'bosh-release-resource'
  spec.version       = BoshReleaseResource::VERSION
  spec.authors       = ['Eric Saxby', 'Tim Hausler']
  spec.email         = ['sax@livinginthepast.org']

  spec.summary       = %q{Deploy a bosh release}
  spec.description   = %q{Deploy a bosh release}
  spec.homepage      = 'https://github.com/sax/bosh-release-resource'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = Dir.glob('{lib,bin}/**/*')
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'minitar', '~> 0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
