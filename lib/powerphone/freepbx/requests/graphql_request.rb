# frozen_string_literal: true

module Powerphone

  module Freepbx

    module Requests

      class GraphqlRequest < BaseRequest

        option :path, default: -> { '/admin/api/api/gql' }, type: Types::Coercible::String
        option :token, type: Types::Coercible::String

        def headers
          {
            'Authorization' => "Bearer #{token}",
            'Content-Type'  => 'application/graphql',
            'Accept'        => 'application/json'
          }
        end

        def on_error(_response)
          nil
        end

      end

    end

  end

end
