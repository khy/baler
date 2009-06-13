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

        # Creates a mapping for the remote source. 
        #
        # There are two forms. The general form is
        #
        #   source.map 'html > body > h1' do |result, instance|
        #     ...
        #   end
        #
        # where the value of the css selector in the document along with the
        # instance is yielded to the block. The more concise form is
        #
        #   source.map :post_title => 'html > body > h1' do |result|
        #     ...
        #   end
        #
        # where the value of the CSS selector is yielded to the block on its own.
        # In the example, the result of the block will be passed to <tt>#post_title=</tt>
        # at gather time.
        #
        # Options:
        #
        # [<tt>:use_context</tt>] When <tt>false</tt>, the selector will not be taken
        #                         relative to the context. Defaults to <tt>true</tt>
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

        # Adds a gather condition that must evaluate to <tt>true</tt> in order for <tt>#gather</tt>
        # to execute. A condition can either be an instance corresponding to an instance method, 
        # or a block.
        def gather_if(*methods, &block)
          add_gather_conditions(methods, block, true)
        end
  
        # Adds a gather condition that must evaluate to <tt>false</tt> in order for <tt>#gather</tt>
        # to execute. A condition can either be an instance corresponding to an instance method, 
        # or a block.
        def gather_unless(*methods, &block)
          add_gather_conditions(methods, block, false)
        end
  
        # Defines a context element using a CSS selector. Mappings will be extracted relative to
        # the the context, be default. Also, <tt>#build</tt> will return an array with a size equal
        # to the number of context elements in a document.
        #
        # A context should correspond to a single instance of the master class. So, if BlogPost is the
        # master class, a context element should contain all of the attributes for a single post.
        def set_context(path)
          @source.context_path = path
        end
        
        # Defines the attributes that will be used by <tt>#build_or_update</tt> to lookup class
        # instances using the ORM
        def set_lookup_attributes(*attributes)
          @source.lookup_attributes = attributes
        end

        # Defines which parser Baler will use
        def uses(parser_type)
          @source.parser_type = parser_type
        end
        alias set_parser uses
        
        private
          def add_gather_conditions(methods, block, expected_value)
            (methods << block).compact.each do |method|
              @source.add_gather_condition(method, expected_value)
            end
          end
      end
    end
  end
end