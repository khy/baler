module Baler
  module Remote
    class Extraction
      attr_reader :attribute
      
      DEFAULT_BLOCK = Proc.new{|result| Baler::Parser.filter(result)}

      def initialize(path = nil, attribute = nil, block = nil, use_context = true)
        @path = (path || '').squeeze(' ').strip
        @attribute = attribute
        @block = block
        @use_context = use_context
      end
      
      def use_context?
        @use_context
      end

      def value(document, instance, index = nil)
        elements = elements(document, index)
        block_value(elements, instance)
      end

      protected
        def block
          @block || DEFAULT_BLOCK
        end

        def block_value(elements, instance)
          if elements
            case block.arity
            when 1: block[elements]
            when 2: block[elements, instance]
            else    nil
            end
          end
        end

        def elements(document, index = nil)
          use_context? ?
            document.relative_elements_for(@path, index) :
            document.absolute_elements_for(@path)
        end
    end
  end
end
