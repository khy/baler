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
          if @context_path.nil?
            absolute_elements_for(path, index)
          elsif not index
            absolute_elements_for(fully_qualify(path))
          else
            context_element(index).try.search(strip_context(path)) ||
              Parser::Element::Array.new
          end
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
          
          def fully_qualify(path)
            "#{context_path} #{strip_context(path)}"
          end
      end
    end
  end
end