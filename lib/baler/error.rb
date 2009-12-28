module Baler
  class Error < ::StandardError; end
  class NoBlockGiven < Error; end
  class NoSourcesDefined < Error; end
  class SourceNotDefinedForName < Error; end
  
  module Parser
    class Error < Baler::Error; end
    class InvalidType < Error; end
  end

  module Remote
    class Source
      class Error < Baler::Error; end
      class URLNotSpecified < Error; end
    end
  end
end
