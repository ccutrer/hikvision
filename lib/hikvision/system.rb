# frozen_string_literal: true

module Hikvision
  class System < Hikvision::Base
    attr_reader :hardware, :network, :time

    def initialize(isapi)
      super()
      @hardware = Hardware.new(isapi)
      @isapi = isapi
      @network = Network.new(isapi)
      @time = Time.new(isapi)
    end
  end
end
