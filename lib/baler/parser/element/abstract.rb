module Baler
  class Parser
    module Element
      class Abstract
        def initialize(raw_element)
          @raw_element = raw_element
        end
        
        alias_method :old_respond_to?, :respond_to?
        def respond_to?(symbol, include_private = false)
          !!(attribute_value(symbol) || inner_html.respond_to?(symbol, include_private) || 
             old_respond_to?(symbol, include_private))
        end
        
        # without an explicit definition, Ruby looks for STDIN
        def split; inner_html.split; end
        
        protected
          include Parser::Search
          
          def method_missing(name, *args)
            attribute_value(name) || inner_html_value(name, *args) || super
          end
          
          def inner_html_value(name, *args)
            if inner_html.respond_to?(name)
              inner_html.send(name, *args)
            end
          end
      end
    end
  end
end