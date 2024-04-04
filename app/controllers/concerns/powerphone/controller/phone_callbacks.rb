# frozen_string_literal: true

module Powerphone

  module Controller

    module PhoneCallbacks

      extend ActiveSupport::Concern

      included do
        Powerphone.configuration.phone.before_actions.each do |action|
          before_action(action.options, &action.block)
        end

        Powerphone.configuration.phone.after_actions.each do |action|
          after_action(action.options, &action.block)
        end

        Powerphone.configuration.phone.around_actions.each do |action|
          around_action(action.options, &action.block)
        end
      end

    end

  end

end
