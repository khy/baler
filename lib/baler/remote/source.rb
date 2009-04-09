require 'forwardable'

module Baler
  module Remote
    class Source
      autoload :Builder, File.dirname(__FILE__) + '/source/builder'
      
      extend Forwardable
      
      attr_accessor :url, :gather_conditions, :lookup_attributes
      attr_reader :master

      def initialize(master, url)
        @master = master
        @url = url
        @mapping_hash = {}
        @gather_conditions = []
        @lookup_attributes = []
      end

      def context
        @context ||= Context.new(self)
      end
      
      def parser
        @parser ||= Parser.new(self)
      end
      
      def config
        @config ||= Configuration.new(self)
      end
      
      def builder
        @builder ||= Builder.new(self)
      end

      def document
        parser.document
      end
      
      def mappings
        @mappings ||= @mapping_hash.values
      end

      def mapped_attributes
        @mapped_attributes ||= @mapping_hash.keys
      end

      def add_mapping(attribute, path, block = nil, context = true)
        new_mapping = Remote::Mapping.new(self, attribute, path)
        new_mapping.block = block unless block.nil?
        new_mapping.context = context unless context.nil?
        @mapping_hash[attribute] = new_mapping
      end
      
      def add_gather_condition(object, expected_value)
        gather_conditions << GatherCondition.new(object, expected_value)
      end
      
      def gather(instance, index = nil, *attributes)
        options = attributes.extract_options
        if gather_conditions_met?(instance) or options[:force]
          mappings.each do |mapping|
            if attributes.empty? or attributes.include?(mapping.attribute)
              instance.__send__("#{mapping.attribute}=", mapping.value(index))
            end
          end
        end
        instance
      end
        
      def build
        Array.new(context.size) do |context_index| 
          build_instance(context_index)
        end
      end
      
      def build_or_update
        Array.new(context.size) do |context_index|
          if existing_instance = existing_instance_for(context_index)
            existing_instance.gather context_index, *non_lookup_attributes
          else
            build_instance(context_index)
          end
        end
      end

      def_delegator(:document, :relative_elements_for, :relative_elements_for)
      def_delegator(:document, :absolute_elements_for, :absolute_elements_for)
      
      private
        def gather_conditions_met?(instance)
          gather_conditions.all?{|gather_condition| gather_condition.met?(instance)}
        end

        def existing_instance_for(context_index)
          if lookup_defined?
            ORM.for(@master).find(build_lookup_hash(context_index))
          end
        end

        def lookup_defined?
          @lookup_attributes.length > 0
        end

        def build_lookup_hash(index)
          lookup_hash = {}
          @lookup_attributes.each do |attribute|
            lookup_hash[attribute.to_sym] = @mapping_hash[attribute].value(index)
          end
          lookup_hash
        end
        
        def build_instance(index)
          @master.new.gather index, :force => true
        end
        
        def non_lookup_attributes
          mapped_attributes - @lookup_attributes
        end
    end
  end
end
