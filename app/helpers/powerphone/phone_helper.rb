module Powerphone

  module PhoneHelper

    def method_missing(method, *args, &block)
      method = method.to_s

      if (method.end_with?('_path') || method.end_with?('_url')) && main_app.respond_to?(method)
        main_app.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private=false)
      method_name = method_name.to_s

      if (method_name.end_with?('_path') || method_name.end_with?('_url')) && main_app.respond_to?(method_name)
        true
      else
        super
      end
    end

  end

end
