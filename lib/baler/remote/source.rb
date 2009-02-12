module Baler
  module Remote
    class Source
      attr_accessor :url
      attr_reader :mappings, :configuration
      alias config configuration 

      def initialize(url)
        @url = url
        @mappings = []
        @configuration = Configuration.new
      end
  
      def map(attribute_map)
        attribute_map.each do |attribute, path|
          @mappings << Mapping.new(self, attribute, path)
        end
        @mappings
      end
    
      def value_for(mapping)
        parser.value_for mapping
      end
    
      def using(parser)
        config.parser = parser
      end

      def parser
        @parser ||= Parser.for self
      end
    end
  end
end