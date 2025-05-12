# frozen_string_literal: true

module Hikvision
  class System < Hikvision::Base
    attr_reader :network, :time

    def initialize(isapi)
      super()
      @isapi = isapi
      @network = Network.new(isapi)
      @time = Time.new(isapi)
    end
  end
end
