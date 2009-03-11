require 'hpricot'

module Baler
  class Parser
    module Document
      class Hpricot < Abstract
        protected
          def raw_search(path)
            raw_document.search(path)
          end
          
        private
          def raw_document
            @raw_document ||= Hpricot(content)
          end
      end
    end
  end
end