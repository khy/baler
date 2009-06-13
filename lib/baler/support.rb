module Baler
  module Support
    module Hash
      def extract_with_defaults!(defaults)
        new_hash = {}
        self.keys.each do |key|
          if defaults.keys.include? key
            new_hash[key] = self.delete key
          end
        end
        defaults.merge new_hash
      end
      
      def reverse_merge(other_hash)
        other_hash.merge(self)
      end
      
      def reverse_merge!(other_hash)
        replace(reverse_merge(other_hash))
      end
    end
    
    module Array
      def extract_options
        last.is_a?(Hash) ? pop : {}
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