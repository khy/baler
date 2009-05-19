module Baler
  module Remote
    class Extraction
      attr_accessor :document, :use_context
      attr_reader :path
      attr_writer :block
      
      DEFAULT_BLOCK = Proc.new{|elements| elements.inner_html}

      def initialize(path, block = nil, use_context = true)
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
      
      def value(document, index = nil, index_absolute_elements = false)
        elements = elements(document, index, index_absolute_elements)
        value = self.block.call(elements) unless elements.empty?

        if value.is_a? Parser::Element::Array
          value = value.length <= 1 ? value.first : value.to_array
        end
        
        if value.is_a? Parser::Element::Abstract
          value = value.inner_html
        end

        value
      end

      protected
        def elements(document, index = nil, index_absolute_elements = false)
          absolute_index = index if index_absolute_elements
          use_context? ?
            document.relative_elements_for(@path, index) :
            document.absolute_elements_for(@path, absolute_index)
        end
    end
  end
end
