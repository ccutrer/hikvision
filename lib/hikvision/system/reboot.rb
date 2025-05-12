# frozen_string_literal: true

module Hikvision
  class System
    def reboot
      @isapi.put("/ISAPI/System/reboot")
    end
  end
end
