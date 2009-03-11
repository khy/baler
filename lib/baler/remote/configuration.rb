module Baler
  module Remote
    class Configuration
      attr_reader :source
    
      def initialize(source)
        @source = source
      end
    end
  end
end