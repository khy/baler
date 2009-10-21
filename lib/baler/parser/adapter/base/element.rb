module Baler
  module Parser
    module Adapter
      module Base
        class Element
          include Parser::Support::Proxy

          def initialize(document, element)
            @document = document
            @element = element
          end

          def subject
            @element
          end

          def search(path)
            @document.collection(@element.search(path))
          end
          
          def wrap(object)
            @document.wrap(object)
          end

          def inner_html
            @element.inner_html
          end

          def attribute(attribute)
            @element[attribute]
          end

          def to_html
            @element.to_html
          end

          def index
            @element.position
          end

          def parent
            @document.element(@element.parent)
          end
        
          def children
            @document.collection(@element.children)
          end
          
          def inspect
            "#<#{self.class}\n#{@element}\n>"
          end
        end
      end
    end
  end
end