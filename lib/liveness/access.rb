# frozen_string_literal: true

require 'ipaddr'

module Liveness
  # Access Control
  #
  # @since 0.3.0
  class Access
    # @param request [Rack::Request]
    # @param config [Liveness::Config]
    #
    # @since 0.3.0
    def initialize(request, config:)
      @request = request
      @config = config
    end

    # Is allowed to access
    #
    # @return [Boolean]
    #
    # @since 0.3.0
    def allowed?
      whitelist? && valid_token?
    end

    # Is token valid
    #
    # @return [Boolean]
    #
    # @since 0.3.0
    def valid_token?
      return true if @config.token.nil?

      @config.token == @request.params['token']
    end

    # Is ip in whitelist
    #
    # @return [Boolean]
    #
    # @sicne 0.3.0
    def whitelist?
      return true if @config.ip_whitelist.empty?
      return true if IPAddr.new('127.0.0.1').include?(@request.ip)
      return true if IPAddr.new('::1').include?(@request.ip)

      @config
        .ip_whitelist
        .map { |ip| IPAddr.new(ip) }
        .reduce(true) { |curr, addr| curr & addr.include?(@request.ip) }
    end
  end
end
