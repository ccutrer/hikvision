# frozen_string_literal: true

module Hikvision
  class Streaming
    def initialize(isapi)
      @isapi = isapi
    end

    def channels
      load_channels.values
    end

    def channel(id)
      load_channels[id]
    end

    def load_channels(options = {})
      return @channels if options.fetch(:cache, true) && instance_variable_defined?(:@channels)

      @channels = {}
      xml = @isapi.get_xml("/ISAPI/Streaming/channels", options)
      xml.xpath("StreamingChannel").each do |c|
        channel = Channel.new(@isapi, c)
        @channels[channel.id] = channel
      end
      @channels
    end
  end
end
