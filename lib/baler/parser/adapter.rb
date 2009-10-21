module Baler
  module Parser
    module Adapter
      autoload :Base, File.dirname(__FILE__) + '/adapter/base'
      autoload :Hpricot, File.dirname(__FILE__) + '/adapter/hpricot'
    end
  end
end
