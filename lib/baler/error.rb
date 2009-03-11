module Baler
  class Error < ::StandardError; end
    
  class Parser
    class Error < Baler::Error; end
    class InvalidTypeError < Error; end
  end
end
