module Baler
  module Parser
    autoload :Adapter, File.dirname(__FILE__) + '/parser/adapter'
    
    ADAPTERS = {:hpricot => Adapter::Hpricot}
    NAMES = ADAPTERS.keys
  
    def self.for(source)
      ADAPTERS[source.config.parser].new(source.url)
    end
  end
end