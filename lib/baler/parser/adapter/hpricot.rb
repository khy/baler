require 'open-uri'
require 'hpricot'

module Baler
  module Parser
    module Adapter
      class Hpricot < Abstract
        def initialize(url)
          super(url)
          @doc = Hpricot(open(@url))
        end
        
        def value_for(mapping)
          if element = @doc.at(mapping.path)
            element.inner_html
          end
        end
      end
    end
  end
end