module Baler
  module Remote
    class Source
      autoload :Builder, File.dirname(__FILE__) + '/source/builder'
      
      attr_accessor :name, :context, :gather_conditions,
        :lookup_block, :lookup_attributes
      attr_writer :parser_adapter
      attr_reader :master

      def initialize(master, name, raw_url = nil)
        @master = master
        @name = name
        @url = URL.build(raw_url) if raw_url

        @documents = {}
        @extractions = []
        @gather_conditions = []
        @lookup_attributes = []
      end

      def builder
        @builder ||= Builder.new(self)
      end

      def document(mapping = {})
        raise URLNotSpecified unless @url
        resolved_urls = @url.resolve(mapping)
        @documents[resolved_urls.to_s] ||= Baler::Parser.document(@parser_adapter, resolved_urls, context)
      end

      def mapped_attributes
        @extractions.map{|extraction| extraction.attribute}
      end

      def set_url(raw_url, &block)
        @url = URL.build(raw_url, &block)
      end

      def add_extraction(path, attribute, use_context = true, &block)
        @extractions << Extraction.new(path, attribute, block, use_context)
      end

      def add_gather_condition(object, expected_value)
        @gather_conditions << GatherCondition.new(object, expected_value)
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
        Array.new(document(options[:url_mapping]).context_size) do |context_index|
          build_instance options.reverse_merge(:index => context_index)
        end
      end
      
      DEFAULT_BUILD_OR_UPDATE_OPTIONS = {
        :url_mapping => {}
      }
      
      def build_or_update(options = {})
        options = options.extract_with_defaults!(DEFAULT_BUILD_OR_UPDATE_OPTIONS)
        
        Array.new(document(options[:url_mapping]).context_size) do |context_index|
          gather_options = options.reverse_merge(:index => context_index)
          instance = build_instance(gather_options)
          
          if existing_instance = lookup_existing_instance(instance)
            regather existing_instance, gather_options.reverse_merge(:attributes => non_lookup_attributes)
          else
            instance
          end
        end
      end

      private
        def gather_conditions_met?(instance)
          gather_conditions.all?{|gather_condition| gather_condition.met?(instance)}
        end

        def build_lookup_hash(instance)
          lookup_hash = {}
          @lookup_attributes.each{|attribute| lookup_hash[attribute.to_sym] = instance[attribute.to_sym]}
          lookup_hash
        end
        
        def build_instance(options = {})
          regather @master.new, options.reverse_merge(:force => true)
        end
        
        def lookup_existing_instance(instance)
          @lookup_block.call(instance) if @lookup_block
        end

        def non_lookup_attributes
          mapped_attributes - @lookup_attributes
        end
        
        def extraction_for(attribute)
          @extractions.select{|extraction| extraction.attribute == attribute}.last
        end

        def regather(instance, options = {})
          instance.gather @name, options
        end
    end
  end
end
