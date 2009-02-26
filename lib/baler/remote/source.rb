module Baler
  module Remote
    class Source
      attr_accessor :url
      attr_reader :master, :mappings, :configuration, :context
      alias config configuration 

      def initialize(master, url)
        @master = master
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

      def gather(instance, context_index = 0)
        mappings.each do |mapping|
          instance.send("#{mapping.attribute}=", mapping.value_for(path, context_index))
        end
        instance
      end
        
      def build
        instances = []
        (0...parser.context.length).each do |context_index|
          instance = @master.new
          instance.gather(context_index)
          instances << instance
        end
      end
        
      def set_context(context)
        @context = context
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
