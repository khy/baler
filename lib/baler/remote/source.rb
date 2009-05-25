module Baler
  module Remote
    class Source
      autoload :Builder, File.dirname(__FILE__) + '/source/builder'
      
      attr_accessor :url, :gather_conditions, :lookup_attributes
      attr_reader :master

      def initialize(master, raw_url_string)
        @master = master
        @url = URL.new(raw_url_string)
        @documents = {}
        @extractions = []
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

      def document(mapping = {})
        url = @url.resolve(mapping)
        @documents[url] = parser.document(url)
      end

      def mapped_attributes
        @extractions.map{|extraction| extraction.attribute}
      end

      def add_extraction(path, attribute, block = nil, use_context = true)
        @extractions << build_extraction(path, attribute, block, use_context)
      end

      def add_gather_condition(object, expected_value)
        gather_conditions << GatherCondition.new(object, expected_value)
      end
      
      DEFAULT_GATHER_OPTIONS = {
        :index => 0,
        :url_mapping => {},
        :attributes => [],
        :force => false
      }
      
      def gather(instance, options = {})
        options = options.extract_with_defaults!(DEFAULT_GATHER_OPTIONS)
        if gather_conditions_met?(instance) or options[:force]
          @extractions.each do |extraction|
            if options[:attributes].empty? or options[:attributes].include?(extraction.attribute)
              value = extraction.value document(options[:url_mapping]), instance, options[:index]
              
              if extraction.attribute
                instance.__send__("#{extraction.attribute}=", value)
              end
            end
          end
        end
        instance
      end
        
      DEFAULT_BUILD_OPTIONS = {
        :url_mapping => {}
      }
        
      def build(options = {})
        options = options.extract_with_defaults!(DEFAULT_BUILD_OPTIONS)
        Array.new(context.size) do |context_index|
          build_instance options.reverse_merge(:index => context_index)
        end
      end
      
      DEFAULT_BUILD_OR_UPDATE_OPTIONS = {
        :url_mapping => {}
      }
      
      def build_or_update(options = {})
        options = options.extract_with_defaults!(DEFAULT_BUILD_OR_UPDATE_OPTIONS)
        
        Array.new(context.size) do |context_index|
          gather_options = options.reverse_merge(:index => context_index)
          
          if existing_instance = existing_instance_for(context_index)
            existing_instance.gather gather_options.reverse_merge(:attributes => non_lookup_attributes)
          else
            build_instance gather_options
          end
        end
      end

      private
        def build_extraction(path, attribute = nil, block = nil, use_context = true)
          Remote::Extraction.new(path, attribute, block, use_context)
        end
      
        def gather_conditions_met?(instance)
          gather_conditions.all?{|gather_condition| gather_condition.met?(instance)}
        end

        def existing_instance_for(index)
          if lookup_defined?
            ORM.for(@master).find(build_lookup_hash(index))
          end
        end

        def lookup_defined?
          @lookup_attributes.length > 0
        end

        def build_lookup_hash(index)
          lookup_hash = {}
          @lookup_attributes.each do |attribute|
            lookup_hash[attribute.to_sym] = extraction_for(attribute).value(document, index)
          end
          lookup_hash
        end
        
        def build_instance(options = {})
          @master.new.gather options.reverse_merge(:force => true)
        end
        
        def non_lookup_attributes
          mapped_attributes - @lookup_attributes
        end
        
        def extraction_for(attribute)
          @extractions.select{|extraction| extraction.attribute == attribute}.last
        end
    end
  end
end
