require 'open-uri'

module Baler
  module Parser
    module Adapter
      module Base
        class Document
          include Parser::Support::Proxy

          def initialize(file_or_url)
            @file_or_url = file_or_url
          end
          
          def subject
            document
          end
          
          def search(path)
            collection(document.search(path))
          end
          
          def wrap(object)
            object
          end
          
          def element(element)
            Base::Element.new(self, element)
          end
          
          def collection(collection = [])
            Base::Collection.new(self, collection)
          end
          
          private
            def document
              @document ||= begin
                file = @file_or_url.is_a?(String) ? open(@file_or_url) : @file_or_url
                Hpricot(file)
              end
            end
        end
      end
    end
  end
end