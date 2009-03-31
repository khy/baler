require 'forwardable'

module Baler
  module Remote
    class Source
      autoload :Builder, File.dirname(__FILE__) + '/source/builder'
      
      extend Forwardable
      
      attr_accessor :url, :mappings, :gather_conditions
      attr_reader :master

      def initialize(master, url)
        @master = master
        @url = url
        @mappings = []
        @gather_conditions = []
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

      def add_mapping(attribute, path, block = nil, context = true)
        new_mapping = Remote::Mapping.new(self, attribute, path)
        new_mapping.block = block unless block.nil?
        new_mapping.context = context unless context.nil?
        mappings << new_mapping
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
          master.new.gather context_index, :force => true
        end
      end
      
      def_delegator(:document, :relative_elements_for, :relative_elements_for)
      def_delegator(:document, :absolute_elements_for, :absolute_elements_for)
      
      private
        def gather_conditions_met?(instance)
          gather_conditions.all?{|gather_condition| gather_condition.met?(instance)}
        end
    end
  end
end
