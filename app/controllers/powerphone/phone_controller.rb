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
    @mounting_point = find_mounting_point
  end

  def find_mounting_point
    mounting_point_options = @engine_config.mounting_point_options

    if mounting_point_options.respond_to?(:call)
      Powerphone::Engine.routes.find_script_name(instance_eval(&mounting_point_options).presence || {})
    else
      Powerphone::Engine.routes.find_script_name({})
    end
  rescue ActionController::UrlGenerationError => e
    raise Powerphone::Errors::ConfigurationRequiredError.new('mounting_point_options', e)
  end

end
