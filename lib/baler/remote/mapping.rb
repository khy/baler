module Baler
  module Remote
    class Mapping
      attr_accessor :source, :attribute, :path

      def initialize(source, attribute, path)
        @source = source
        @attribute = attribute
        @path = path
      end

      def relative_path
        path_without_context
      end

      def absolute_path
        "#{@source.context} #{path_without_context}".strip
      end

      def value
        @source.value_for self
      end
      
      private
        def path_without_context
          @path.sub(/^#{@source.context}/, '').strip
        end
    end
  end
end
