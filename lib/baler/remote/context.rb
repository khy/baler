module Baler
  module Remote
    class Context
      attr_reader :source
      attr_accessor :path
      
      def initialize(source, path = nil)
        @source = source
        @path = path
      end
      
      def elements
        @elements ||= @source.document.absolute_elements_for @path
      end
      
      def size
        elements.length
      end
    end
  end
end
        