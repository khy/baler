module Baler
  module Remote
    class Mapping
      attr_accessor :source, :attribute, :path

      def initialize(source, attribute, path)
        @source = source
        @attribute = attribute
        @path = path
      end

      def value
        @source.value_for self
      end
    end
  end
end