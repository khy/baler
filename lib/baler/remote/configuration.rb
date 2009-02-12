module Baler
  module Remote
    class Configuration
      DEFAULT_PARSER = Parser::NAMES.first
    
      attr_accessor :parser
    
      def initialize(parser = DEFAULT_PARSER)
        @parser = parser
      end
    end
  end
end