module Baler
  module Parser
    class Element
      include Parser::Support::Proxy
      
      def initialize(element)
        @element = element
      end

      def subject
        @element
      end
      
      def wrap(object)
        Parser.wrap(object)
      end
      
      def inspect
        "#<#{self.class} #{@element.subject}>"
      end
    end
  end
end