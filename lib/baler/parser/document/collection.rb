module Baler
  module Parser
    class Document
      class Collection
        attr_reader :documents

        def initialize(documents)
          @documents = documents
        end

        def relative_elements_for(path, index = nil)
          index ?
            elements_for_index(path, index) :
            map_and_combine_documents{|document| document.relative_elements_for(path)}
        end

        def absolute_elements_for(path, index = nil)
          elements = map_and_combine_documents{|document| document.absolute_elements_for(path)}
          index ? elements[index] : elements
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

          def elements_for_index(path, index)
            relative_index = index
            @documents.each do |document|
              if document.context_size >= relative_index
                return document.relative_elements_for(path, relative_index)
              else
                relative_index -= document.context_size
              end
            end
          end
      end
    end
  end
end