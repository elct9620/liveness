# frozen_string_literal: true

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
    # @since 0.1.0
    def allowed?
      valid_token?
    end

    # Is token valid
    #
    # @return [Boolean]
    #
    # @since 0.1.0
    def valid_token?
      return true if @config.token.nil?

      @config.token == @request.params['token']
    end
  end
end
