module Baler
  module Parser
    module Adapter
      module Base
        class Collection
          include Parser::Support::Proxy
          
          def initialize(document, collection = [])
            @document = document
            @collection = collection
          end

          def subject
            @collection
          end

          def search(path)
            @document.collection(@collection.search(path))
          end
          
          def wrap(object)
            @document.wrap(object)
          end
          
          def to_array
            ::Array.new(@collection)
          end
          
          def inspect
            "#<#{self.class}\n[#{@collection.join(",\n")}]\n>"
          end
        end
      end
    end
  end
end