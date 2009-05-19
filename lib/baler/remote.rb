module Baler
  module Remote
    autoload :Source, File.dirname(__FILE__) + '/remote/source'
    autoload :Context, File.dirname(__FILE__) + '/remote/context'
    autoload :URL, File.dirname(__FILE__) + '/remote/url'
    autoload :Extraction, File.dirname(__FILE__) + '/remote/extraction'
    autoload :Configuration, File.dirname(__FILE__) + '/remote/configuration'
    autoload :GatherCondition, File.dirname(__FILE__) + '/remote/gather_condition'
  end
end