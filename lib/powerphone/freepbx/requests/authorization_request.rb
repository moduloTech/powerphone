# frozen_string_literal: true

module Powerphone

  module Freepbx

    module Requests

      class AuthorizationRequest < BaseRequest

        option :client_id, type: Types::Coercible::String
        option :client_secret, type: Types::Coercible::String
        option :grant_type, default: -> { 'client_credentials' }, type: Types::Coercible::String
        option :path, default: -> { '/admin/api/api/token' }, type: Types::Coercible::String
        option :scope, default: -> {}, type: Types::Coercible::String.optional

        def on_success(response)
          response['access_token']
        end

        def on_error(_response)
          nil
        end

        def body
          b = {
            grant_type:    grant_type,
            client_id:     client_id,
            client_secret: client_secret
          }

          scope.nil? ? b : b.merge(scope: scope)
        end

      end

    end

  end

end
