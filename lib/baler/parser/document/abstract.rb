require 'open-uri'

module Baler
  module Parser
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
            absolute_elements_for absolute_path(path)
          else
            if context = context_element(index)
              context.search path
            else
              Parser::Element::Array.new
            end
          end
        end

        def absolute_elements_for(path, index = nil)
          search(path, index)
        end
      
        def context_element(index)
          absolute_elements_for(@context_path, index).first
        end

        def context_size
          absolute_elements_for(@context_path).size
        end

        protected
          include Parser::Search
          
          def content
            @content ||= open(@url)
          end

          def absolute_path(relative_path)
            "#{context_path} #{relative_path}"
          end
      end
    end
  end
end