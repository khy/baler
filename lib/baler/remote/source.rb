module Baler
  module Remote
    class Source
      attr_accessor :url
      attr_reader :mappings, :configuration, :context
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
    
      def set_context(context)
        @context = context
      end
    
      def value_for(mapping)
        parser.value_for mapping
      end
    
      def parser_name=(parser_name)
        config.parser_name = parser_name
      end
      alias uses parser_name=
      
      def parser_name
        config.parser_name
      end
      
      def parser
        @parser ||= Parser.for self
      end
    end
  end
end
