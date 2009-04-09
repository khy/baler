module Baler
  module ORM
    autoload :Abstract, File.dirname(__FILE__) + '/orm/abstract'
    autoload :ActiveRecord, File.dirname(__FILE__) + '/orm/active_record'
    
    TYPE_MAP = {:active_record => ActiveRecord}.freeze
    
    def self.for(klass)
      if orm_proxy_class = TYPE_MAP.values.find{|orm| orm.for?(klass)}
        orm_proxy_class.new(klass)
      else
        raise Baler::ORM::ClassNotRecognized
      end
    end
  end
end