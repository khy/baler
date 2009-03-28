module Baler
  module Remote
    class Mapping
      attr_reader :path, :context
      attr_writer :block
      attr_accessor :source, :attribute

      DEFAULT_BLOCK = Proc.new{|elements| elements.inner_html}

      def initialize(source, attribute, path)
        @source = source
        @attribute = attribute
        self.path = path
        @context = true
      end
      
      def path=(path)
        @path = path.squeeze(' ').strip
      end

      def block
        @block || DEFAULT_BLOCK
      end

      def context=(context)
        @context = !!(context)
      end

      alias use_context? context

      def relative_path
        path_without_context
      end

      def absolute_path
        [@source.context.path, path_without_context].join(' ')
      end

      def elements(index = 0)
        use_context? ?
          @source.document.relative_elements_for(relative_path, index) :
          @source.document.absolute_elements_for(relative_path)
      end
      
      def value(index = 0)
        elements = elements(index)
        result = block.call(elements) unless elements.empty?
        (result.is_a?(Array) and result.length <= 1) ? result.first : result.try.to_array
      end
      
      private
        def path_without_context
          @path.sub(/^#{@source.context.path}/, '')
        end
    end
  end
end
