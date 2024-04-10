# frozen_string_literal: true

module Powerphone

  module Config

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
        @mounting_point_options = nil
        @parent_controller = nil
        @custom_stylesheet = nil
      end

      attr_reader :admin, :phone, :custom_stylesheet

      def mounting_point_options(&block)
        return @mounting_point_options if block.nil?

        @mounting_point_options = block
      end

      def parent_controller=(parent_controller)
        case parent_controller
        when String, Class
          @parent_controller = parent_controller
        else
          raise TypeError, I18n.t('exceptions.type_error', type: '[Class, String]')
        end
      end

      def custom_stylesheet=(custom_stylesheet)
        case custom_stylesheet
        when String
          @custom_stylesheet = custom_stylesheet
        when Symbol
          @custom_stylesheet = custom_stylesheet.to_s
        else
          raise TypeError, I18n.t('exceptions.type_error', type: '[String, Symbol]')
        end
      end

      def parent_controller
        raise Powerphone::Errors::ConfigurationRequiredError.new('parent_controller') if @parent_controller.nil?

        @parent_controller.is_a?(String) ? @parent_controller.constantize : @parent_controller
      end

    end

  end

end
