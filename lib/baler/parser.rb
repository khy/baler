module Baler
  class Parser
    autoload :Document, File.dirname(__FILE__) + '/parser/document'
    autoload :Element, File.dirname(__FILE__) + '/parser/element'
    
    TYPES = [:hpricot]
    DEFAULT_TYPE = Parser::TYPES.first
    
    def initialize(source)
      @source = source
      @documents = {}
    end

    def type
      @type || DEFAULT_TYPE
    end

    def type=(type)
      unless TYPES.include?(type)
        raise Baler::Parser::InvalidTypeError
      end
      
      @type = type
    end

    def document(url)
      @documents[url] ||= Document.for(type, url, @source.context.path)
    end
    
    module Search
      def search(path, index = nil)
        Search.normalize(raw_search(path), index)
      end
        
      def self.normalize(raw_array, index = nil)
        raw_array.map!{|element| Element.for(element)}
        Element::Array.new(index ? ([raw_array[index]].compact) : raw_array)
      end
    end
  end
end
