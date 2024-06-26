# frozen_string_literal: true

module Powerphone

  module Config

    Action = Struct.new(:options, :block)
    SipUser = Struct.new(:profile_id, :profile_name, :extension, :password, :language)

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

      class PhoneCallbackable < Callbackable

        def initialize
          super()

          @sip_user_evaluator = nil
        end

        def sip_user(caller=nil, &block)
          if block.nil?
            sip_user = SipUser.new
            caller.instance_exec(sip_user, &@sip_user_evaluator)
            validate_sip_user(sip_user)
          elsif caller.nil?
            @sip_user_evaluator = block
          else
            raise ArgumentError, 'wrong number of arguments (given 1, expected 0 when block given)'
          end
        end

        private

        def validate_sip_user(sip_user)
          # Required values
          %i[profile_id extension password].each do |attribute|
            if sip_user.send(attribute).nil?
              raise Powerphone::Errors::ConfigurationRequiredError.new("sip_user/#{attribute}")
            end
          end

          # Optional values
          sip_user.profile_name ||= SecureRandom.alphanumeric
          sip_user.language = validate_language(sip_user.language)

          sip_user
        end

        VALID_LANGUAGES = %w[fr ja zh ru tr nl es de pl pt].freeze
        def validate_language(language)
          return 'auto' if language.blank?

          # Handle symbols (#to_s) and Rails format (:fr_FR)
          language = language.to_s.gsub('_', '-')
          language_code, _country_code = language.split('-')
          return 'auto' unless VALID_LANGUAGES.include?(language_code)

          language
        end

      end

      def initialize
        super()

        @admin = Callbackable.new
        @phone = PhoneCallbackable.new
        @mounting_point_options = nil
        @parent_controller = nil
        @custom_stylesheet = nil
        @custom_javascript = nil
      end

      attr_reader :admin, :phone, :custom_stylesheet, :custom_javascript

      def mounting_point_options(&block)
        return @mounting_point_options if block.nil?

        @mounting_point_options = block
      end

      def route_options(caller)
        options = if mounting_point_options.respond_to?(:call)
                    caller.instance_eval(&mounting_point_options)
                  else
                    mounting_point_options
                  end

        options.presence || {}
      rescue ActionController::UrlGenerationError => e
        raise Powerphone::Errors::ConfigurationRequiredError.new('mounting_point_options', e)
      end

      def mounting_point(caller)
        Powerphone::Engine.routes.find_script_name(route_options(caller))
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

      def custom_javascript=(custom_javascript)
        case custom_javascript
        when String
          @custom_javascript = custom_javascript
        when Symbol
          @custom_javascript = custom_javascript.to_s
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
