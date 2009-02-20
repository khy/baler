module Baler
  module Remote
    class Configuration
      DEFAULT_PARSER_NAME = Parser::NAMES.first
    
      attr_accessor :parser_name
    
      def initialize(parser_name = DEFAULT_PARSER_NAME)
        unless Parser::NAMES.include?(parser_name)
          raise Baler::Parser::InvalidNameError
        end
        
        @parser_name = parser_name
      end
    end
  end
end