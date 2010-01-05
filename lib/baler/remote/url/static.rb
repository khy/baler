module Baler
  module Remote
    module URL
      class Static
        def initialize(raw_urls)
          @raw_urls = raw_urls
        end
        
        def resolve(mapping)
          @raw_urls.is_a?(Array) ?
            @raw_urls.map{|raw_url| URL.resolve(raw_url, mapping)} :
            URL.resolve(@raw_urls, mapping)
        end
      end
    end
  end
end