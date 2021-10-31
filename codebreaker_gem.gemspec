# frozen_string_literal: true

require_relative 'lib/codebraker/version'

Gem::Specification.new do |spec|
  spec.name          = 'codebraker'
  spec.version       = Codebraker::VERSION
  spec.authors       = ['KaLen9ula']
  spec.email         = ['andruhovickola167@gmail.com']
  spec.summary       = 'Gem for a Codebraker game'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.add_development_dependency('fasterer', '~> 0.8.3')
  spec.add_development_dependency('i18n', '~> 1.8.10')
  spec.add_development_dependency('lefthook', '~> 0.7.7')
  spec.add_development_dependency('pry', '~> 0.14.1')
  spec.add_development_dependency('rubocop', '~> 1.22.1')
  spec.add_development_dependency('rubocop-performance', '~> 1.11.5')
  spec.add_development_dependency('simplecov', '~> 0.21.2')

  spec.add_development_dependency('ffaker', '~> 2.20.0')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('rspec_junit_formatter', '~> 0.4.1')
  spec.add_development_dependency('rubocop-rspec', '~> 2.5.0')
end
