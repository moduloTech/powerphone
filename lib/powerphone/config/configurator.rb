# frozen_string_literal: true

module Powerphone

  module Config

    class Configurator

      def self.configure
        raise ArgumentError, I18n.t('exceptions.argument_error_block_required') unless block_given?

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

      delegate :mounting_point_options, :parent_controller=, :custom_stylesheet=, to: :config

    end

  end

end
