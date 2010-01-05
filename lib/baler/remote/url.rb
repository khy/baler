module Baler
  module Remote
    module URL
      autoload :Static, File.dirname(__FILE__) + '/url/static'
      autoload :Dynamic, File.dirname(__FILE__) + '/url/dynamic'

      def self.build(raw_url, adapter_type = nil, &block)
        block ? URL::Dynamic.new(raw_url, adapter_type, block) : URL::Static.new(raw_url)
      end

      def self.resolve(raw_string, mapping)
        resolved_url = raw_string.dup
        mapping.each do |pattern, replacement|
          pattern = pattern.to_s unless pattern.is_a? Regexp
          resolved_url.gsub! pattern, replacement
        end
        resolved_url
      end
    end
  end
end
