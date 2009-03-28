require 'forwardable'

module Baler
  module Remote
    class Source
      extend Forwardable
      
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
      
      def add_mapping(attribute, path, block = nil, context = true)
        new_mapping = Remote::Mapping.new(self, attribute, path)
        new_mapping.block = block unless block.nil?
        new_mapping.context = context unless context.nil?
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
      
      def_delegator(:document, :relative_elements_for, :relative_elements_for)
      def_delegator(:document, :absolute_elements_for, :absolute_elements_for)
      
      class Builder
        def initialize(source)
          @source = source
        end

        def map(options, &block)
          context = options.delete(:context)
          options.each do |attribute, path|
            @source.add_mapping(attribute, path, block, context)
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
