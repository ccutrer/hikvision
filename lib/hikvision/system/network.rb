# frozen_string_literal: true

module Hikvision
  class Network < Hikvision::Base
    attr_reader :integration

    def initialize(isapi)
      super()
      @isapi = isapi
      @integration = Integration.new(isapi)
    end
  end
end
