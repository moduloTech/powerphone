require 'powerphone/version'

if defined?(Rails)
  require 'powerphone/engine'
else
  require 'active_support/all'
end

require 'powerphone/types'

require 'powerphone/freepbx/client'
require 'powerphone/freepbx/requests/base_request'
require 'powerphone/freepbx/requests/graphql_request'
require 'powerphone/freepbx/requests/authorization_request'
require 'powerphone/freepbx/requests/fetch_all_core_users_request'

module Powerphone
  # Your code goes here...
end
