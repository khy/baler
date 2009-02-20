module Baler
  module Remote
    class Configuration
      DEFAULT_PARSER = Parser::NAMES.first
    
      attr_accessor :parser
    
      def initialize(parser = DEFAULT_PARSER)
        unless Parser::NAMES.include?(parser)
          raise Baler::Parser::InvalidOptionError
        end
        
        @parser = parser
      end
    end
  end
end