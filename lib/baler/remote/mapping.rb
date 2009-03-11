module Baler
  module Remote
    class Mapping
      attr_reader :path
      attr_accessor :source, :attribute

      def initialize(source, attribute, path)
        @source = source
        @attribute = attribute
        self.path = path
      end
      
      def path=(path)
        @path = path.squeeze(' ').strip
      end

      def relative_path
        path_without_context
      end

      def absolute_path
        [@source.context.path, path_without_context].join(' ')
      end

      def elements(index = 0)
        @source.document.relative_elements_for(relative_path, index)
      end
      
      def value(index = 0)
        elements(index).map{|element| element.inner_html}.element_or_array
      end
      
      private
        def path_without_context
          @path.sub(/^#{@source.context.path}/, '')
        end
    end
  end
end
