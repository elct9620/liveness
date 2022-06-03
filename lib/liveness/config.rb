# frozen_string_literal: true

module Liveness
  # Config of liveness
  #
  # @sicne 0.1.0
  class Config
    # @since 0.1.0
    attr_reader :dependencies

    # @since 0.3.0
    attr_accessor :token, :ip_whitelist

    # @return [Liveness::Config]
    #
    # @since 0.1.0
    def initialize(container: Liveness.container, &block)
      @container = container
      @dependencies = []
      @ip_whitelist = []

      instance_exec(self, &block) if defined?(yield)
    end

    # Add dependency config
    #
    # @param name [Symbol] the dependency name
    # @param options [Hash] the dependency options
    # @param block [Proc] the block for config dependency
    #
    # @since 0.1.0
    def add(name, **options, &block)
      dependency = @container.create(name, **options, &block)
      return if dependency.nil?

      @dependencies << dependency
    end
  end
end
