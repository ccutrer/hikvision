# frozen_string_literal: true

module Hikvision
  class Image
    class Channel < Hikvision::Base
      attr_reader :shutter

      def initialize(isapi, xml)
        super()
        @isapi = isapi
        @base_xml = xml
        @shutter = Shutter.new(isapi, self)
      end

      add_xml(:base, -> { url })
      add_xml(:capabilities, -> { "#{url}/capabilities" })

      add_getter(:id, :base, "id", &:to_i)

      def url
        "/ISAPI/Image/channels/#{id}"
      end

      private

      def before_update
        @isapi.cache.delete("/ISAPI/Image/channels")
      end
    end
  end
end
