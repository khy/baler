module Baler
  module Support
    module Hash
      def compose(other_hash)
        new_hash = self.clone
        new_hash.each{|key, value| new_hash[key] = other_hash[value]}
      end
      
      def extract_with_defaults!(defaults)
        new_hash = {}
        self.keys.each do |key|
          if defaults.keys.include? key
            new_hash[key] = self.delete key
          end
        end
        defaults.merge new_hash
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