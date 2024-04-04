# frozen_string_literal: true

module Powerphone

  module Controller

    module AdminCallbacks

      extend ActiveSupport::Concern

      included do
        Powerphone.configuration.admin.before_actions.each do |action|
          before_action(action.options, &action.block)
        end

        Powerphone.configuration.admin.after_actions.each do |action|
          after_action(action.options, &action.block)
        end

        Powerphone.configuration.admin.around_actions.each do |action|
          around_action(action.options, &action.block)
        end
      end

    end

  end

end
