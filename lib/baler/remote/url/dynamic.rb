module Baler
  module Remote
    module URL
      class Dynamic
        def initialize(raw_url, adapter_type, block)
          @raw_url = raw_url
          @block = block
          @adapter_type = adapter_type
        end
        
        def resolve(mapping)
          resolved_url = URL.resolve(@raw_url.to_s, mapping)
          @block.call(Baler::Parser.adapter(@adapter_type, resolved_url))
        end
      end
    end
  end
end