# frozen_string_literal: true

require 'timeout'

module Liveness
  # The required dependency for services
  #
  # @since 0.1.0
  class Dependency
    # @since 0.1.0
    attr_accessor :timeout

    # @since 0.1.0
    def initialize(timeout: 5, &block)
      @timeout = timeout

      instance_exec(self, &block) if defined?(yield)
    end

    # Check the dependency service alive
    #
    # @return [Boolean]
    #
    # @since 0.1.0
    def alive?
      Timeout.timeout(@timeout) do
        check!
      rescue RuntimeError
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
