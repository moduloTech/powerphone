# frozen_string_literal: true

module Powerphone

  module Errors

    class ConfigurationRequiredError < RuntimeError

      attr_accessor :configuration_name
      attr_reader :cause

      def initialize(configuration_name, cause=nil)
        @configuration_name = configuration_name
        @cause = cause
        msg = I18n.t('exceptions.powerphone/errors/configuration_required_error', name: configuration_name)

        super(msg)
      end

    end

  end

end
