module Baler
  module Parser
    module Adapter
      module Base
        autoload :Document, File.dirname(__FILE__) + '/base/document'
        autoload :Collection, File.dirname(__FILE__) + '/base/collection'
        autoload :Element, File.dirname(__FILE__) + '/base/element'          
      end
    end
  end
end
