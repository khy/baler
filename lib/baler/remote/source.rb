module Baler
  module Remote
    class Source
      attr_accessor :url, :mappings
      attr_reader :master

      def initialize(master, url)
        @master = master
        @url = url
        @mappings = []
      end

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
      
      def builder
        @builder ||= Builder.new(self)
      end
      
      def add_mapping(attribute, path, block)
        new_mapping = Remote::Mapping.new(self, attribute, path)
        new_mapping.block = block
        mappings << new_mapping
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
      
      class Builder
        def initialize(source)
          @source = source
        end

        def map(attribute_map, &block)
          attribute_map.each do |attribute, path|
            @source.add_mapping(attribute, path, block)
          end
          @source
        end
        
        def set_context(path)
          @source.context.path = path
        end

        def uses(parser_type)
          @source.parser.type = parser_type
        end
        alias set_parser uses
      end
    end
  end
end
