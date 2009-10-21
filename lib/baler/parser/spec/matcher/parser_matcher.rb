module ParserMatcher
  class MatchUnderlyingHTML
    def initialize(expected)
      @expected = expected
    end
  
    def matches?(target)
      @target = target
      expected_stripped_html == target_stripped_html
    end
  
    def failure_message
      "expected #{target_stripped_html.inspect}\nto match\n#{expected_stripped_html.inspect}"
    end
    
    def negative_failure_message
      "expected #{target_stripped_html.inspect}\nto not match\n#{expected_stripped_html.inspect}"
    end
    
    private
      def expected_stripped_html
        @expected_stripped_html ||= strip_html_object(@expected)
      end
      
      def target_stripped_html
        @target_stripped_html ||= strip_html_object(@target)
      end
    
      def strip_html_object(object)
        if object.respond_to?(:each)
          array = []
          object.each{|e| array << stripped_html_for(e)}
          array
        else
          stripped_html_for(object)
        end
      end
      
      def stripped_html_for(object)
        html = object.respond_to?(:to_html) ? object.to_html : ''
        html.strip!
        html.gsub!(/\s+/, '')
      end
  end

  def match_underlying_html_of(expected)
    MatchUnderlyingHTML.new(expected)
  end
end
      