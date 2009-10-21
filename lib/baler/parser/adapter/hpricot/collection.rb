module Baler
  module Parser
    module Adapter
      module Hpricot
        class Collection < Adapter::Base::Collection
          def initialize(document, collection = [])
            collection = (collection === Array) ? ::Hpricot::Elements[*collection] : collection
            super(document, collection)
          end
        end
      end
    end
  end
end