# frozen_string_literal: true

require "httparty"
require "nokogiri"

module Hikvision
  class ResponseError < RuntimeError
    def initialize(xml)
      @xml = xml
      super(status_string)
    end

    def status_code
      @xml.at_xpath("statusCode").inner_html.to_i
    end

    def status_string
      @xml.at_xpath("statusString").inner_html
    end

    def sub_status_code
      @xml.at_xpath("subStatusCode").inner_html
    end
  end

  class ISAPI
    include HTTParty

    attr_accessor :cache
    attr_reader :image, :streaming, :system

    def initialize(ip, username, password, args = { auth_type: "digest_auth", https: false })
      @cache = {}
      @auth_type = args[:auth_type]
      @base_uri = "http#{args[:https] ? "s" : ""}://#{ip}"
      @auth = { username:, password: }
      @image = Hikvision::Image.new(self)
      @streaming = Hikvision::Streaming.new(self)
      @system = Hikvision::System.new(self)
    end

    def get(path, options = {})
      options = default_request_options.merge(options)
      if @cache.key?(path) && options.fetch(:cache, true)
        @cache[path]
      else
        @cache[path] = self.class.get(@base_uri + path, options)
      end
    end

    def get_xml(path, options = {})
      data = get(path, options)
      unless ["200"].include?(data.response.code)
        raise "could not get xml of #{@base_uri}#{path} code:#{data.response.code}"
      end

      Nokogiri::XML(data.body).remove_namespaces!.root
    end

    def put(path, options = {})
      @cache.delete(path)
      options = default_request_options.merge(options)
      self.class.put(@base_uri + path, options)
    end

    def put_xml(path, options = {})
      data = put(path, options)

      return true if data.response.code == "200"

      xml = Nokogiri::XML(data.body).remove_namespaces!.root
      raise ResponseError, xml
    end

    private

    def default_request_options
      {
        "#{@auth_type}": @auth
      }
    end
  end
end
