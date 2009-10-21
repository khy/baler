module Baler
  module Parser
    class Element
      include Parser::Support::Proxy
      
      def initialize(document, element)
        @document = document
        @element = element
      end

      def subject
        @element
      end
      
      def wrap(object)
        @document.wrap(object)
      end
      
      def inspect
        "#<#{self.class} #{@element.subject}>"
      end
    end
  end
end