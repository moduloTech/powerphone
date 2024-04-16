class Powerphone::PhoneController < Powerphone.configuration.parent_controller

  include Powerphone::Controller::PhoneCallbacks

  layout 'application'

  before_action :fetch_configuration

  def index
  end

  def configuration
  end

  private

  def fetch_configuration
    @configuration = Powerphone::Configuration.fetch
    @engine_config = Powerphone.configuration
    @mounting_point = @engine_config.mounting_point(self)
    @sip_user = @engine_config.phone.sip_user(self)
  end

end
