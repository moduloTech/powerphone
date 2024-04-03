module Powerphone

  class ApplicationController < ActionController::Base

    include Powerphone::Controller::Callbacks

  end

end
