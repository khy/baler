module Baler
  class Error < ::StandardError; end
  class NoBlockGiven < Error; end
  class NoSourcesDefined < Error; end
  class SourceNotDefinedForName < Error; end
  
  class Parser
    class Error < Baler::Error; end
    class InvalidType < Error; end
  end
  
  module ORM
    class Error < Baler::Error; end
    class ClassNotRecognized < Error; end
  end
end
