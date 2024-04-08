# frozen_string_literal: true

require 'dry-initializer'
require 'httparty'

module Powerphone

  module Freepbx

    class Client

      extend Dry::Initializer

      option :base_url, as: :url, type: Types::Coercible::String
      option :debug, default: -> { false }, type: Types::Strict::Bool

      def execute(request)
        response = HTTParty.post(url(request),
                                 query: request.query, body: request.body, headers: request.headers,
                                 debug_output: $stdout)

        if response.success?
          request.on_success(response)
        else
          request.on_error(response)
        end
      end

      private

      def uri
        @uri ||= URI(@url)
      end

      def url(request)
        uri.path = request.path
        uri.to_s
      end

    end

  end

end
