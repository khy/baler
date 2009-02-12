module Baler
  module Parser
    module Adapter
      autoload :Abstract, File.dirname(__FILE__) + '/adapter/abstract'
      autoload :Hpricot, File.dirname(__FILE__) + '/adapter/hpricot'
    end
  end
end