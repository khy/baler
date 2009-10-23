module Baler
  module Parser
    class Collection
      include Parser::Support::Proxy

      def initialize(document, collection)
        @document = document
        @collection = collection
      end

      def subject
        @collection
      end

      def wrap(object)
        @document.wrap(object)
      end

      def inspect
        "#<#{self.class} [#{@collection.join(", ")}]>"
      end
    end
  end
end