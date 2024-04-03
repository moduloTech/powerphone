# frozen_string_literal: true

module Powerphone

  module ImageHelper

    # Display svg and not use svg as image in image_tag
    # I don't want the credit here because I used an answer in stackoverflow
    # Definitely the best helper for front developer
    def fa_icon_tag(path)
      File.open(Powerphone::Engine.root.join("app/assets/images/powerphone/icons/#{path}.svg"), 'rb') do |file|
        # rubocop:disable Rails/OutputSafety
        raw file.read
        # rubocop:enable Rails/OutputSafety
      end
    end

  end

end
