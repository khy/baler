require 'lib/parser'

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
      end
    
      def value_for(mapping)
        @parser = Parser.for self
        @parser.value_for mapping
      end
    
      def using(parser)
        config.parser = parser
      end
    end
  
    class Mapping
      attr_accessor :source, :attribute, :path
    
      def initialize(source, attribute, path)
        @source = source
        @attribute = attribute
        @path = path
      end
    
      def value
        @source.value_for self
      end
    end
  
    class Configuration
      DEFAULT_PARSER = Parser::NAMES.first
    
      attr_accessor :parser
    
      def initialize(parser = DEFAULT_PARSER)
        @parser = parser
      end
    end
  end
end