module Baler
  module Remote
    class Extraction
      attr_accessor :document, :use_context
      attr_reader :path
      attr_writer :block
      
      DEFAULT_BLOCK = Proc.new{|elements| elements.inner_html}

      def initialize(document, path, block = nil, use_context = true)
        @document = document
        self.path = path
        @block = block
        @use_context = use_context
      end
      
      def path=(path)
        @path = path.squeeze(' ').strip
      end

      def block
        @block || DEFAULT_BLOCK
      end

      alias use_context? use_context

      def elements(index = 0)
        use_context? ?
          @document.relative_elements_for(@path, index) :
          @document.absolute_elements_for(@path)
      end
      
      def value(index = 0)
        elements = elements(index)
        result = self.block.call(elements) unless elements.empty?
        (result.is_a?(Array) and result.length <= 1) ? result.first : result.try.to_array
      end
    end
  end
end
