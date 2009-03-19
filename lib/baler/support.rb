module Baler
  module Support
    module Hash
      def compose(other_hash)
        new_hash = self.clone
        new_hash.each{|key, value| new_hash[key] = other_hash[value]}
      end
    end
  end
end

class Hash
  include Baler::Support::Hash
end
