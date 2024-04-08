# frozen_string_literal: true

module Powerphone

  module Freepbx

    module Requests

      class BaseRequest

        extend Dry::Initializer

        def on_success(response)
          response
        end

        def on_error(response)
          response
        end

        def query
          nil
        end

        def body
          nil
        end

        def headers
          nil
        end

      end

    end

  end

end
