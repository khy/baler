module Baler
  module Parser
    module Adapter
      class Abstract
        attr_accessor :url

        def initialize(url)
          @url = url
        end

        def value_for(mapping)
        end
      end
    end
  end
end