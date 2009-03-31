module Baler
  module Support
    module Object
      def try
        Try.new(self)
      end
      
      class Try
        def initialize(receiver)
          @receiver = receiver
        end
        
        def method_missing(method, *args, &block)
          @receiver.respond_to?(method) ?
            @receiver.__send__(method, *args, &block) : @receiver
        end
      end    
    end    

    module Hash
      def compose(other_hash)
        new_hash = self.clone
        new_hash.each{|key, value| new_hash[key] = other_hash[value]}
      end
    end
    
    module Array
      def extract_options
        last.is_a?(Hash) ? pop : {}
      end
    end
  end
end

class Object
  include Baler::Support::Object
end

class Hash
  include Baler::Support::Hash
end

class Array
  include Baler::Support::Array
end