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
      
      def value(index = nil, index_absolute_elements = false)
        elements = elements(index, index_absolute_elements)
        result = self.block.call(elements) unless elements.empty?
        (result.is_a?(Array) and result.length <= 1) ? result.first : result.try.to_array
      end
      
      protected
        def elements(index = nil, index_absolute_elements = false)
          absolute_index = index if index_absolute_elements
          use_context? ?
            @document.relative_elements_for(@path, index) :
            @document.absolute_elements_for(@path, absolute_index)
        end
    end
  end
end