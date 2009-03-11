module Baler
  class Parser
    module Element
      class Abstract
        def initialize(raw_element)
          @raw_element = raw_element
        end
        
        def method_missing(name, *args)
          attribute_value(name)
        end
        
        protected
          include Parser::Search

      end
    end
  end
end