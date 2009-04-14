module Baler
  module Remote
    class Source
      class Builder
        def initialize(source)
          @source = source
        end

        def map(options, &block)
          context = options.include?(:context) ? options.delete(:context) : true
          options.each do |attribute, path|
            @source.add_mapping(attribute, path, block, context)
          end
          @source
        end
        
        def extract(*args, &block)
          options = args.extract_options
          context = options.include?(:context) ? options[:context] : true
          path, index = args
          @source.build_extraction(path, block, context).value(index, true)
        end
        
        def gather_if(*methods, &block)
          add_gather_conditions(methods, block, true)
        end
  
        def gather_unless(*methods, &block)
          add_gather_conditions(methods, block, false)
        end
  
        def set_context(path)
          @source.context.path = path
        end
        
        def set_lookup_attributes(*attributes)
          @source.lookup_attributes = attributes
        end

        def uses(parser_type)
          @source.parser.type = parser_type
        end
        alias set_parser uses
        
        private
          def add_gather_conditions(methods, block, expected_value)
            methods.each do |method|
              @source.add_gather_condition(method, expected_value)
            end
            @source.add_gather_condition(block, expected_value) if block
          end
      end
    end
  end
end