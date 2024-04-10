require 'importmap-rails'
require 'turbo-rails'

require 'powerphone/errors/configuration_required_error'

require 'powerphone/config/engine_configuration'
require 'powerphone/config/configurator'

module Powerphone

  class Engine < ::Rails::Engine

    isolate_namespace Powerphone

    initializer 'powerphone-engine.importmap', before: 'importmap' do |app|
      app.config.importmap.paths += [Engine.root.join('config/importmap.rb')]
    end

    initializer 'powerphone-engine.assets' do |app|
      app.config.assets.precompile += %w[powerphone_manifest.js]
    end

    initializer 'powerphone-engine.public_assets' do |app|
      app.config.app_middleware.use(
        Rack::Static,
        urls: %w[/powerphone-assets],
        root: Engine.root.join('public')
      )
    end

  end

  class << self

    def configure(&block)
      Config::Configurator.configure(&block)
    end

    def configuration
      @configuration ||= Config::EngineConfiguration.new
    end

    def configuration=(configuration)
      unless configuration.is_a?(Config::EngineConfiguration)
        raise ArgumentError,
              'configuration must be a Powerphone::Config::EngineConfiguration'
      end

      @configuration = configuration
    end

  end

end
