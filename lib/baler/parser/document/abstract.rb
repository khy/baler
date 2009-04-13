require 'open-uri'

module Baler
  class Parser
    module Document
      class Abstract
        attr_accessor :url, :context_path
      
        def initialize(url, context_path = nil)
          @url = url
          @context_path = context_path
        end

        def relative_elements_for(path, index = nil)
          return absolute_elements_for(path, index) unless @context_path
          context_element(index || 0).try.search(strip_context(path)) ||
            Parser::Element::Array.new
        end

        def absolute_elements_for(path, index = nil)
          search(path, index)
        end
      
        def context_element(index)
          search(@context_path, index).first
        end

        protected
          include Parser::Search
          
          def content
            @content ||= open(@url)
          end

          def strip_context(path)
            path.sub(/^#{@context_path}/, '')
          end
      end
    end
  end
end