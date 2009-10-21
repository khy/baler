module Baler
  module Parser
    module Adapter
      module Hpricot
        class Document < Adapter::Base::Document
          def wrap(object)
            case object
            when ::Hpricot::Elem then element(object)
            when ::Hpricot::Elements, Array then collection(object)
            else object
            end
          end
          
          def element(element)
            Hpricot::Element.new(self, element)
          end
          
          def collection(collection = [])
            Hpricot::Collection.new(self, collection)
          end
        end
      end
    end
  end
end