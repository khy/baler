module Baler
  module Parser
    class Document
      include Parser::Support::Proxy
      
      attr_accessor :context_path
    
      def initialize(document, context_path = nil)
        @document = document
        @context_path = context_path
      end

      def wrap(object)
        case object
        when Parser::Adapter::Base::Element then element(object)
        when Parser::Adapter::Base::Collection then collection(object)
        else object
        end
      end

      def element(object)
        Parser::Element.new(self, object)
      end
      
      def collection(object = [])
        Parser::Collection.new(self, object)
      end

      def relative_elements_for(path, index = nil)
        if @context_path.nil?
          absolute_elements_for(path, index)
        elsif not index
          absolute_elements_for absolute_path(path)
        else
          if context = context_elements[index]
            context.search path
          else
            collection
          end
        end
      end

      def absolute_elements_for(path, index = nil)
        results = @document.search(path)
        wrap(index ? results[index] : results)
      end

      def context_size
        context_elements.size
      end
      
      def inspect
        "#<#{self.class} context: '#{@context_path}'\n#{@document.subject}>"
      end
      
      protected
        def absolute_path(relative_path)
          "#{@context_path} #{relative_path}".strip
        end
      
        def subject
          @document
        end
        
        def context_elements
          @context_elements ||= absolute_elements_for(@context_path)
        end
    end
  end
end
