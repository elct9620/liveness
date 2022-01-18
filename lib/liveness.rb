# frozen_string_literal: true

require 'rack'

require_relative 'liveness/version'
require_relative 'liveness/dependency'
require_relative 'liveness/container'
require_relative 'liveness/config'
require_relative 'liveness/status'

# The Rack middleware to provide health check endpoints.
#
# @since 0.1.0
module Liveness
  # @sicne 0.1.0
  LOCK = Mutex.new

  module_function

  # @return [Liveness::Config]
  #
  # @since 0.1.0
  def config(&block)
    return @config if @config

    LOCK.synchronize do
      return @config if @config

      @config = Config.new(&block)
    end

    @config
  end

  # @return [Liveness::Container]
  #
  # @since 0.1.0
  def container
    @container ||= Container.new
  end
end
