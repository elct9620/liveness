# frozen_string_literal: true

module Liveness
  # :nodoc:
  module Dependencies
    # The PostgreSQL Provider
    #
    # @since 0.2.0
    class Redis < Dependency
      # @see [Liveness::Dependency#check!]
      #
      # @since 0.2.0
      def check!
        return false unless defined?(::Redis)

        redis = ::Redis.new
        redis.ping == 'PONG'
      rescue ::Redis::BaseError
        false
      end
    end

    Liveness.container.register(:redis, Redis)
  end
end
