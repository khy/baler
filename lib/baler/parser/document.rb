module Baler
  module Parser
    class Document
      autoload :Collection, File.dirname(__FILE__) + '/document/collection'

      include Parser::Support::Proxy

      def initialize(document, context_object = nil)
        @document = document
        @context_object = context_object
      end

      def subject
        @document
      end

      def wrap(object)
        Parser.wrap(object)
      end

      def relative_elements_for(path, index = nil)
        if context_path.nil?
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

      def context_path
        @context_path ||= @context_object.is_a?(Proc) ?
          @context_object.call(@document) : @context_object
      end

      def context_size
        context_elements.size
      end
      
      def inspect
        "#<#{self.class} context: '#{@context_path}'\n#{@document.subject}>"
      end

      protected
        def absolute_path(relative_path)
          "#{context_path} #{relative_path}".strip
        end
      
        def subject
          @document
        end
        
        def context_elements
          @context_elements ||= absolute_elements_for(context_path)
        end
    end
  end
end
