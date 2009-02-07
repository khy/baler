require 'lib/base'

module Baler
  include Base::InstanceMethods
  
  def self.included(base)
    base.extend Base::ClassMethods
  end
end