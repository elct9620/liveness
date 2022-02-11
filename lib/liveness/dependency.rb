# frozen_string_literal: true

require 'timeout'

module Liveness
  # The required dependency for services
  #
  # @since 0.1.0
  class Dependency
    # @since 0.1.0
    attr_accessor :name, :timeout

    # @since 0.1.0
    def initialize(name: nil, timeout: 5, &block)
      @name = name
      @timeout = timeout

      instance_exec(self, &block) if defined?(yield)
    end

    # Return status
    #
    # @return [Hash]
    #
    # @since 0.2.0
    def status
      {
        status: alive? ? 'ok' : 'failed'
      }
    end

    # Check the dependency service alive
    #
    # @return [Boolean]
    #
    # @since 0.1.0
    def alive?
      Timeout.timeout(@timeout) do
        check!
      rescue StandardError
        false
      end
    end

    # Check the dependency service alive
    #
    # @return [Boolean]
    #
    # @since 0.1.0
    def check!
      raise NotImplementedError
    end
  end
end
