module Baler
  module Parser
    class Collection
      include Parser::Support::Proxy

      def initialize(collection)
        @collection = collection
      end

      def subject
        @collection
      end

      def wrap(object)
        Parser.wrap(object)
      end

      def inspect
        "#<#{self.class} [#{@collection.join(", ")}]>"
      end
    end
  end
end