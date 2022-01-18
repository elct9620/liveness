# frozen_string_literal: true

module Liveness
  # The dependency provider container
  #
  # @since 0.1.0
  class Container
    # @return [Liveness::Container]
    #
    # @since 0.1.0
    def initialize
      @dependencies = {}
    end

    # Register new dependency type
    #
    # @param name [Symbol] the dependency name
    # @param klass [Class] the class to register
    #
    # @since 0.1.0
    def register(name, klass)
      @dependencies[name.to_sym] = klass
    end

    # Create a dependency
    #
    # @param name [Symbol] the dependency name
    # @param block [Proc] the block to configure dependency
    #
    # @return [Liveness::Dependency|NilClass]
    #
    # @since 0.1.0
    def create(name, **options, &block)
      klass = @dependencies[name.to_sym]
      return if klass.nil?

      options[:name] ||= name
      klass.new(**options, &block)
    end
  end
end
