module Powerphone

  class AdminController < ApplicationController

    include Powerphone::Controller::AdminCallbacks

    layout 'powerphone/admin'

    before_action :fetch_configuration

    private

    def fetch_configuration
      @configuration = Powerphone::Configuration.fetch
    end

  end

end
