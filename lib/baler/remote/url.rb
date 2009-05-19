module Baler
  module Remote
    class URL
      def initialize(raw_string)
        @raw_string = raw_string
      end
      
      def resolve(mapping = {})
        @raw_string
      end
      alias to_s resolve
    end
  end
end