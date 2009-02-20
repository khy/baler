module Baler
  class Error < ::StandardError; end
    
  module Parser
    class Error < Baler::Error; end
    class InvalidNameError < Error; end
  end
end
