module Baler
  module Parser
    class Document
      class Collection
        def initialize(documents)
          @documents = documents
        end

        def relative_elements_for(path, index = nil)
          map_and_combine_documents{|document| document.relative_elements_for(path, index)}
        end

        def absolute_elements_for(path, index = nil)
          map_and_combine_documents{|document| document.absolute_elements_for(path, index)}
        end

        def context_paths
          @documents.map{|document| document.context_path}
        end

        def context_path
          context_paths.first
        end

        def context_size
          map_and_combine_documents{|document| document.context_size}
        end

        private
          def map_and_combine_documents
            @documents.map do |document|
              yield(document) if block_given?
            end.inject{|result, elements| result + elements}
          end
      end
    end
  end
end