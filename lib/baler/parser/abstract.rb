require 'open-uri'

module Baler
  module Parser
    class Abstract
      attr_accessor :source
      
      def initialize(source)
        self.source = source
      end
      
      def value_for(mapping)
      end
      
      def context
      end

      protected
        def content
          @content ||= open(source.url)
        end

        def strip_context(path)
          path.sub(/^#{@source.context}/, '').strip
        end
    end
  end
end