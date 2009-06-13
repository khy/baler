module Baler
  module Parser
    autoload :Document, File.dirname(__FILE__) + '/parser/document'
    autoload :Element, File.dirname(__FILE__) + '/parser/element'
    
    TYPES = [:hpricot]
    DEFAULT_TYPE = Parser::TYPES.first

    module Search
      def search(path, index = nil)
        Search.normalize(raw_search(path), index)
      end
        
      def self.normalize(raw_array, index = nil)
        raw_array.map!{|raw_element| Element.wrap(raw_element)}
        Element::Array.new(index ? ([raw_array[index]].compact) : raw_array)
      end
    end
  end
end
