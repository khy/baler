require File.dirname(__FILE__) + '/../../parser'
require File.dirname(__FILE__) + '/matcher/parser_matcher'

BLOG_PATH = File.dirname(__FILE__) + '/asset/blog.html'

Spec::Runner.configure do |config|
  config.include(ParserMatcher)
end
