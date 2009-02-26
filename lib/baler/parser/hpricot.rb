require 'hpricot'

module Baler
  module Parser
    class Hpricot < Abstract
      def initialize(source)
        super(source)
      end
      
      def value_for(path, context_index = 0)
        if context_element = context[context_index]
          elements = context_element.search(strip_context(path))
          
          unless elements.empty?
            elements.map{|element| element.inner_html}.array_or_element
          end
        end
      end
      
      def context
        @context ||= doc.search(source.context)
      end
      
      protected
        def doc
          @doc ||= Hpricot(content)
        end
    end
  end
end