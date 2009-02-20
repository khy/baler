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
      
      protected
        def content
          @content ||= open(source.url)
        end
    end
  end
end