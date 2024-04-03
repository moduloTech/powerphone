module Powerphone

  class Configuration < ApplicationRecord

    validates :sip_domain, presence: true
    validates :wss_server, presence: true
    validates :wss_port, presence: true
    validates :wss_path, presence: true

    def self.fetch
      @configuration ||= find_or_initialize_by(id: 1)

      @configuration.save(validate: false) unless @configuration.persisted?

      @configuration
    rescue ActiveRecord::ConnectionNotEstablished, ActiveRecord::StatementInvalid => e
      # These errors can happen when the database was not yet created (for instance, when the CI runs
      # the tests or build the docker image)
      Rails.logger.error("The database can not be found: #{e}")
      nil
    end

  end

end
