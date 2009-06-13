module Baler
  module Parser
    module Element
      class Hpricot < Abstract
        def inner_html
          @raw_element.inner_html
        end
        alias to_s inner_html
        
        def attribute_value(attribute)
          @raw_element[attribute]
        end
        
        def to_html
          @raw_element.to_html
        end
        
        protected
          def raw_search(path)
            @raw_element.search(path)
          end
      end
    end
  end
end