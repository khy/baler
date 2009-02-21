module Baler
  module Remote
    autoload :Source, File.dirname(__FILE__) + '/remote/source'
    autoload :Mapping, File.dirname(__FILE__) + '/remote/mapping'
    autoload :Configuration, File.dirname(__FILE__) + '/remote/configuration'
  end
end