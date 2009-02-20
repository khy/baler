require 'hpricot'

module Baler
  module Parser
    class Hpricot < Abstract
      def initialize(source)
        super(source)
      end
      
      def value_for(mapping)
        if element = doc.at(mapping.path)
          element.inner_html
        end
      end
      
      protected
        def doc
          @doc ||= Hpricot(content)
        end
    end
  end
end