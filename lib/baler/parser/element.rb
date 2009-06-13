module Baler
  module Parser
    module Element
      autoload :Abstract, File.dirname(__FILE__) + '/element/abstract'
      autoload :Hpricot, File.dirname(__FILE__) + '/element/hpricot'
      
      TYPE_MAP = {:hpricot => Hpricot}
      CLASS_TYPE_MAP = {::Hpricot::Elem => :hpricot}
      
      def self.wrap(element)
        klass = class_for(element)
        klass.new(element)
      end
      
      def self.class_for(element)
        type = CLASS_TYPE_MAP[element.class]
        TYPE_MAP[type]
      end
      
      class Array < ::Array
        def to_array
          ::Array.new(self)
        end
        
        alias_method :super_respond_to?, :respond_to?
        def respond_to?(symbol, include_private = false)
          !!(first.respond_to?(symbol, include_private) || 
             super_respond_to?(symbol, include_private))
        end

        protected
          def method_missing(method, *args, &block)
            first.respond_to?(method) ?
              map!{|element| element.send(method, *args)} : super
          end
      end
    end
  end
end