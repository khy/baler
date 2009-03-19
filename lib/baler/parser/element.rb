module Baler
  class Parser
    module Element
      autoload :Abstract, File.dirname(__FILE__) + '/element/abstract'
      autoload :Hpricot, File.dirname(__FILE__) + '/element/hpricot'
      
      TYPE_MAP = {:hpricot => Hpricot}
      CLASS_TYPE_MAP = {::Hpricot::Elem => :hpricot}
      
      def self.for(element)
        CLASS_TYPE_MAP.compose(TYPE_MAP)[element.class].new(element)
      end
      
      class Array < ::Array
        alias_method :old_respond_to?, :respond_to?
        def respond_to?(symbol, include_private = false)
          !!(first.respond_to?(symbol, include_private) || 
             old_respond_to?(symbol, include_private))
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