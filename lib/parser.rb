require 'lib/adapter/hpricot'

module Baler
  module Parser
    ADAPTERS = {:hpricot => Adapter::Hpricot}
    NAMES = ADAPTERS.keys
  
    def self.for(source)
      ADAPTERS[source.config.parser].new(source.url)
    end
  end
end