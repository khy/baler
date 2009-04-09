module Baler
  module ORM
    class Abstract
      attr_reader :klass
      
      def initialize(klass)
        @klass = klass
      end
    end
  end
end