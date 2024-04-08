require_relative 'lib/powerphone/version'

Gem::Specification.new do |spec|
  spec.name = 'powerphone'
  spec.version = Powerphone::VERSION
  spec.authors = ['Matthieu Ciappara']
  spec.email = ['ciappa_m@modulotech.fr']
  spec.homepage = 'https://github.com/moduloTech/powerphone'
  spec.summary = <<~TEXT
    A fully featured browser based WebRTC SIP phone for Asterisk to integrate in a Ruby on Rails application.
  TEXT
  spec.description = spec.summary
  spec.license = 'AGPL-3.0-only'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/moduloTech/powerphone/blob/master/CHANGELOG.md'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib,public}/**/*', 'LICENSE', 'Rakefile', 'README.md', 'CHANGELOG.md']
  end

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'rails', '>= 7.0.0'

  spec.add_dependency 'importmap-rails', '~> 1.2', '>= 1.2.3'
  spec.add_dependency 'turbo-rails', '~> 2.0', '>= 2.0.5'

  spec.add_dependency 'dry-initializer', '~> 3.1', '>= 3.1.1'
  spec.add_dependency 'dry-types', '~> 1.7', '>= 1.7.2'
  spec.add_dependency 'httparty', '~> 0.21'
end
