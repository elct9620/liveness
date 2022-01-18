# frozen_string_literal: true

require 'rack'

require_relative 'liveness/version'
require_relative 'liveness/status'

# The Rack middleware to provide health check endpoints.
#
# @since 0.1.0
module Liveness
end
