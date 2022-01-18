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

    # @return [Liveness::Status]
    #
    # @since 0.1.0
    def initialize(env)
      @env = env
    end

    # The depend services status
    #
    # @return [Hash]
    #
    # @since 0.1.0
    def metrics
      {}
    end

    # The Liveness status
    #
    # @return [Boolean]
    #
    # @since 0.1.0
    def live?
      true
    end

    # @return [Rack::Response]
    #
    # @since 0.1.0
    def response
      [
        live? ? 200 : 503,
        { 'Content-Type' => 'application/json' },
        [metrics.to_json]
      ]
    end
  end
end
