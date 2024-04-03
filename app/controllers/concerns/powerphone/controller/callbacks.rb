# frozen_string_literal: true

module Powerphone

  module Controller

    module Callbacks

      extend ActiveSupport::Concern

      included do
        Powerphone.configuration.before_actions.each do |action|
          before_action(action.options, &action.block)
        end

        Powerphone.configuration.after_actions.each do |action|
          after_action(action.options, &action.block)
        end

        Powerphone.configuration.around_actions.each do |action|
          around_action(action.options, &action.block)
        end
      end

    end

  end

end
