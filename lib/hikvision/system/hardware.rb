# frozen_string_literal: true

module Hikvision
  class System
    class Hardware < Hikvision::Base
      class << self
        def url
          "/ISAPI/System/Hardware"
        end
      end

      def initialize(isapi)
        super()
        @isapi = isapi
      end

      add_xml(:base, url)

      add_bool_getter(:ir_light?, :base, "HardwareService/IrLightSwitch/mode", "open")
      add_setter(:ir_light=, :base, "HardwareService/IrLightSwitch/mode", TrueClass, FalseClass) do |v|
        v ? "open" : "close"
      end
    end
  end
end
