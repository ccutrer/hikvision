# frozen_string_literal: true

module Hikvision
  class Image
    class Channel
      class Shutter < Hikvision::Base
        def initialize(isapi, channel)
          super()
          @isapi = isapi
          @channel = channel
        end

        add_xml(:base, -> { url })

        add_getter(:speed, :base, "ShutterLevel")
        add_setter(:speed=, :base, "ShutterLevel", String)
        add_opt_getter(:speed_opts, :capabilities, "Shutter/ShutterLevel")

        def url
          "#{@channel.url}/shutter"
        end

        private

        def load_capabilities(...)
          @channel.load_capabilities(...)
        end
      end
    end
  end
end
