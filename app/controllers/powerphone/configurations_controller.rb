module Powerphone

  class ConfigurationsController < AdminController

    def show
    end

    def update
      respond_to do |format|
        format.turbo_stream do
          @configuration.update!(update_params)
          redirect_to configuration_path
        rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => e
          @error = e
        end

        format.any do
          render plain: "Unknown format: #{format.format}", status: :not_acceptable
        end
      end
    end

    private

    def update_params
      params.require(:configuration).permit(:sip_domain, :wss_server, :wss_path, :wss_port)
    end

  end

end
