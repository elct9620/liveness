# frozen_string_literal: true

require 'ipaddr'

module Liveness
  # Access Control
  #
  # @since 0.3.0
  class Access
    # @since 0.3.2
    LOCAL_IPV4 = IPAddr.new('127.0.0.1')
    LOCAL_IPV6 = IPAddr.new('::1')

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
      local? || (whitelist? && valid_token?)
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

    # Is from localhost
    #
    # @return [Boolean]
    #
    # @since 0.3.2
    def local?
      LOCAL_IPV4.include?(@request.ip) || LOCAL_IPV6.include?(@request.ip)
    end

    # Is ip in whitelist
    #
    # @return [Boolean]
    #
    # @sicne 0.3.0
    def whitelist?
      return true if @config.ip_whitelist.empty?

      @config
        .ip_whitelist
        .map { |ip| IPAddr.new(ip) }
        .reduce(true) { |curr, addr| curr & addr.include?(@request.ip) }
    end
  end
end
