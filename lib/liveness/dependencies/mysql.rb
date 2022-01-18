# frozen_string_literal: true

module Liveness
  # :nodoc:
  module Dependencies
    # The MySQL Provider
    #
    # @since 0.1.0
    class MySQL < Dependency
      # @see [Liveness::Dependency#check!]
      #
      # @since 0.1.0
      def check!
        # TODO: Add Sequel Support
        return false unless defined?(ActiveRecord::Base)

        ActiveRecord::Base.connection.exec_query('SELECT 1 as ping')&.first&.[]('ping')&.to_s == '1'
      end
    end

    Liveness.container.register(:mysql, MySQL)
  end
end
