module Baler
  module Remote
    class Source
      class Builder
        def initialize(source)
          @source = source
        end

        DEFAULT_MAP_OPTIONS = {
          :use_context => true
        }

        def map(*args, &block)
          mappings = args.extract_options
          options = mappings.extract_with_defaults!(DEFAULT_MAP_OPTIONS)

          args.each do |anonymous_path|
            @source.add_extraction(anonymous_path, nil, options[:use_context], &block)
          end

          mappings.each do |attribute, path|
            @source.add_extraction(path, attribute, options[:use_context], &block)
          end

          @source
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