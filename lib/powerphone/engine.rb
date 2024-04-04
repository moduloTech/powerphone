require 'importmap-rails'
require 'turbo-rails'

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

  Action = Struct.new(:options, :block)

  class EngineConfiguration

    class Callbackable

      def initialize
        super()

        @before_actions = []
        @around_actions = []
        @after_actions = []
      end

      attr_reader :before_actions, :around_actions, :after_actions

      def before_action(options={}, &block)
        @before_actions << Action.new(options, block)
      end

      def around_action(options={}, &block)
        @around_actions << Action.new(options, block)
      end

      def after_action(options={}, &block)
        @after_actions << Action.new(options, block)
      end

    end

    def initialize
      super()

      @admin = Callbackable.new
      @phone = Callbackable.new
    end

    attr_reader :admin, :phone

  end

  class Configurator

    def self.configure
      raise ArgumentError.new('A block is needed for Powerphone.configure') unless block_given?

      builder = new
      yield builder

      Powerphone.configuration = builder.config
    end

    def initialize
      super()

      @config = EngineConfiguration.new
    end

    attr_reader :config

    def admin
      @config.admin
    end

    def phone
      @config.phone
    end

  end

  class << self

    def configure(&block)
      Configurator.configure(&block)
    end

    def configuration
      @configuration ||= EngineConfiguration.new
    end

    def configuration=(configuration)
      unless configuration.is_a?(EngineConfiguration)
        raise ArgumentError,
              'configuration must be a Powerphone::EngineConfiguration'
      end

      @configuration = configuration
    end

  end

end
