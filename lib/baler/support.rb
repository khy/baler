module Baler
  module Support
    module Array
      def array_or_element
        self.length == 1 ? self.first : self
      end
    end
  end
end

class Array
  include Baler::Support::Array
end