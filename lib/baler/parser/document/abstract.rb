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
          (has_context? and index) ?
            context_element(index).search(path) :
            absolute_elements_for(full_path(path), index)
        end

        def full_path(path)
          @context? "#@context + #{path}" : path
        end

        def absolute_elements_for(path, index = nil)
          search(path, index)
        end
      
        def context_element(index)
          search(@context_path, index).first
        end

        def has_context?
          !@context_path.nil?
        end

        protected
          include Parser::Search
          
          def content
            @content ||= open(@url)
          end
      end
    end
  end
end