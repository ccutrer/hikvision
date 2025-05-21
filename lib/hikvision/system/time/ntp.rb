# frozen_string_literal: true

module Hikvision
  class System
    class Time
      class Ntp < Hikvision::Base
        class << self
          def url
            "/ISAPI/System/time/ntpServers"
          end
        end

        def initialize(isapi)
          super()
          @isapi = isapi
        end

        add_xml(:base, url)

        def address
          (address_format == :hostname) ? host : ip_address
        end

        def address=(value)
          if Resolv::IPv4::Regex.match?(value)
            self.host = nil
            self.ip_address = value
            self.address_format = :ipaddress
          else
            self.ip_address = nil
            self.host = value
            self.address_format = :hostname
          end
        end

        add_getter(:host, :base, "NTPServer/hostName")
        add_setter(:host=, :base, "NTPServer/hostName", String, NilClass)

        add_getter(:ip_address, :base, "NTPServer/ipAddress")
        add_setter(:ip_address=, :base, "NTPServer/ipAddress", String, NilClass)

        add_getter(:address_format, :base, "NTPServer/addressingFormatType", &:to_sym)
        add_setter(:address_format=, :base, "NTPServer/addressingFormatType", Symbol) do |v|
          raise ArgumentError, "Invalid address format type" unless %i[hostname ipaddress].include?(v)

          v
        end

        add_getter(:sync_interval, :base, "NTPServer/synchronizeInterval", &:to_i)
        add_setter(:sync_interval=, :base, "NTPServer/synchronizeInterval", String)

        add_getter(:port, :base, "NTPServer/portNo", &:to_i)
        add_setter(:port=, :base, "NTPServer/portNo", Integer)
      end
    end
  end
end
