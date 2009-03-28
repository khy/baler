module Baler
  autoload :Base, File.dirname(__FILE__) + '/baler/base'
  autoload :Remote, File.dirname(__FILE__) + '/baler/remote'
  autoload :Parser, File.dirname(__FILE__) + '/baler/parser'
  
  include Base::InstanceMethods
  
  def self.included(base)
    base.extend Base::ClassMethods
  end
end

require File.dirname(__FILE__) + '/baler/error'
require File.dirname(__FILE__) + '/baler/support'
