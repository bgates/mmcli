# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mmcli/version'

Gem::Specification.new do |spec|
  spec.name          = 'mmcli'
  spec.license       = 'MIT'
  spec.version       = Mmcli::VERSION
  spec.authors       = ['Brian Gates']
  spec.email         = ['briandotgates@gmail.com']

  spec.summary       = 'Command line tool for manifest management'
  spec.homepage      = 'https://github.com/bgates/mmcli'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ['mmcli']
  spec.require_paths = ['lib']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.add_dependency 'gem-man', '~> 0'
  spec.add_dependency('methadone', '~> 1.9.5')
  spec.add_development_dependency 'aruba', '~> 0'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rdoc', '~> 6'
  spec.add_development_dependency 'ronn', '~> 0'
  spec.add_development_dependency 'test-unit', '~> 3'
end
