# frozen_string_literal: true

module Powerphone

  module Freepbx

    module Requests

      class FetchAllCoreUsersRequest < GraphqlRequest

        def on_success(response)
          response.dig('data', 'allCoreUsers', 'coreUser')
        end

        def body
          <<~GRAPHQL
            query {
              allCoreUsers {
                coreUser {
                  extension
                  name
                }
              }
            }
          GRAPHQL
        end

      end

    end

  end

end
