module Baler
  class Parser
    module Element
      autoload :Abstract, File.dirname(__FILE__) + '/element/abstract'
      autoload :Hpricot, File.dirname(__FILE__) + '/element/hpricot'
      
      TYPE_MAP = {:hpricot => Hpricot}
      CLASS_TYPE_MAP = {::Hpricot::Elem => :hpricot}
      
      def self.for(element)
        CLASS_TYPE_MAP.compose(TYPE_MAP)[element.class].new(element)
      end
    end
  end
end