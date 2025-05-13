# frozen_string_literal: true

module Hikvision
  class Image
    def initialize(isapi)
      @isapi = isapi
    end

    def channels
      load_channels.values
    end

    def channel(id)
      if instance_variable_defined?(:@channels)
        load_channels[id]
      else
        xml = @isapi.get_xml("/ISAPI/Image/channels/#{id}")
        Channel.new(@isapi, xml.at_xpath("ImageChannel"))
      end
    end

    def load_channels(options = {})
      return @channels if options.fetch(:cache, true) && instance_variable_defined?(:@channels)

      @channels = {}
      xml = @isapi.get_xml("/ISAPI/Image/channels", options)
      xml.xpath("ImageChannellist/ImageChannel").each do |c|
        channel = Channel.new(@isapi, Nokogiri::XML(c.to_s))
        @channels[channel.id] = channel
      end
      @channels
    end
  end
end
