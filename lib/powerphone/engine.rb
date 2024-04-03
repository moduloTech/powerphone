require 'importmap-rails'
require 'turbo-rails'

module Powerphone

  class Engine < ::Rails::Engine

    isolate_namespace Powerphone

    initializer 'powerphone-engine.importmap', before: 'importmap' do |app|
      app.config.importmap.paths += [Engine.root.join('config/importmap.rb')]
    end

    initializer "powerphone-engine.assets" do |app|
      app.config.assets.precompile += %w[powerphone_manifest.js]
    end
  end

end
