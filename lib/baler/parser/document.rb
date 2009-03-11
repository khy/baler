module Baler
  class Parser
    module Document
      autoload :Abstract, File.dirname(__FILE__) + '/document/abstract'
      autoload :Hpricot, File.dirname(__FILE__) + '/document/hpricot'
    
      TYPE_MAP = {:hpricot => Hpricot}
    
      def self.for(parser_type, url, context_path)
        TYPE_MAP[parser_type].new(url, context_path)
      end
    end
  end
end