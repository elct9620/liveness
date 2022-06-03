# frozen_string_literal: true

module Liveness
  # The status endpoint to return check status
  #
  # @since 0.1.0
  class Status
    class << self
      # @since 0.1.0
      def call(env)
        new(env).response
      end
    end

    # @since 0.3.0
    HEADERS = { 'Content-Type' => 'application/json' }.freeze

    # @since 0.3.0
    FORBIDDEN_MESSAGE = { message: 'access denied' }.freeze

    # @return [Liveness::Status]
    #
    # @since 0.1.0
    def initialize(env, config: Liveness.config)
      @env = env
      @request = Rack::Request.new(env)
      @config = config
    end

    # The depend services status
    #
    # @return [Hash]
    #
    # @since 0.1.0
    def metrics
      @metrics ||= @config.dependencies.map do |dependency|
        Thread.new { [dependency.name, dependency.status] }
      end.map(&:value).to_h
    end

    # The Liveness status
    #
    # @return [Boolean]
    #
    # @since 0.1.0
    def live?
      metrics
        .values
        .map { |service| service[:status] == 'ok' }
        .reduce(true, :&)
    end

    # @return [Rack::Response]
    #
    # @since 0.1.0
    def response
      access = Access.new(@request, config: @config)
      return forbidden unless access.allowed?

      [
        live? ? 200 : 503,
        HEADERS.dup,
        [metrics.to_json]
      ]
    end

    # @return [Rack::Response]
    #
    # @since 0.3.0
    def forbidden
      [
        403, HEADERS.dup, [FORBIDDEN_MESSAGE.to_json]
      ]
    end
  end
end
