module Baler
  module Support
    module Hash
      def compose(other_hash)
        new_hash = self.clone
        new_hash.each{|key, value| new_hash[key] = other_hash[value]}
      end
      
      def compose!(other_hash)
        self.replace(self.compose(other_hash))
      end
    end
    
    module Array
      def element_or_array
        self.length > 1 ? self : self.first
      end
    end
  end
end

class Hash
  include Baler::Support::Hash
end

class Array
  include Baler::Support::Array
end