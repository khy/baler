module Baler
  class Error < ::StandardError; end
    
  module Parser
    class Error < Baler::Error; end
    class InvalidOptionError < Error; end
  end
end