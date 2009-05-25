module Baler
  module Remote
    class URL
      def initialize(raw_string)
        @raw_string = raw_string
      end
      
      def resolve(mapping = {})
        resolved_string = @raw_string.dup
        mapping.each do |pattern, replacement|
          unless [String, Regexp].include?(pattern.class)
            pattern = pattern.to_s
          end

          resolved_string.gsub! pattern, replacement
        end
        resolved_string
      end
    end
  end
end