module Baler
  module Remote
    class Source
      attr_accessor :url
      attr_reader :master, :mappings

      def initialize(master, url)
        @master = master
        @url = url
        @mappings = []
      end
  
      def map(attribute_map, &block)
        attribute_map.each do |attribute, path|
          new_mapping = Mapping.new(self, attribute, path)
          new_mapping.block = block
          @mappings << new_mapping
        end
        @mappings
      end

      def gather(instance, index = nil)
        mappings.each do |mapping|
          instance.send("#{mapping.attribute}=", mapping.value(index))
        end
        instance
      end
        
      def build
        Array.new(context.size) do |context_index| 
          master.new.gather(context_index)
        end
      end
        
      def set_context(path)
        context.path = path
      end
      
      def uses(parser_type)
        parser.type = parser_type
      end
      alias set_parser uses
      
      def context
        @context ||= Context.new(self)
      end
      
      def parser
        @parser ||= Parser.new(self)
      end
      
      def document
        parser.document
      end
      
      def config
        @config ||= Configuration.new(self)
      end
      alias configuration config
    end
  end
end
