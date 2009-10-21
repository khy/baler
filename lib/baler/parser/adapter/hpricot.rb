require 'hpricot'

module Baler
  module Parser
    module Adapter
      module Hpricot
        autoload :Document, File.dirname(__FILE__) + '/hpricot/document'
        autoload :Collection, File.dirname(__FILE__) + '/hpricot/collection'
        autoload :Element, File.dirname(__FILE__) + '/hpricot/element'          
      end
    end
  end
end
