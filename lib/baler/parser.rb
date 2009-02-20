module Baler
  module Parser
    autoload :Abstract, File.dirname(__FILE__) + '/parser/abstract'
    autoload :Hpricot, File.dirname(__FILE__) + '/parser/hpricot'
    
    OPTIONS = {:hpricot => Hpricot}
    NAMES = OPTIONS.keys
    
    def self.for(source)
      OPTIONS[source.config.parser_name].new(source)
    end
  end
end
