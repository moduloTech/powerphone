module Powerphone

  class PhoneController < ApplicationController

    include Powerphone::Controller::PhoneCallbacks

    layout 'powerphone/phone'

    before_action :fetch_configuration

    def index
    end

    private

    def fetch_configuration
      @configuration = Powerphone::Configuration.fetch
    end

  end

end
