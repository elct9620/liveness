# frozen_string_literal: true

module Liveness
  # The dependency providers
  #
  # @since 0.1.0
  module Dependencies
    require_relative 'dependencies/postgresql'
    require_relative 'dependencies/mysql'
  end
end
