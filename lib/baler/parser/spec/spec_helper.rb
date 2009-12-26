require File.dirname(__FILE__) + '/../../parser'
require File.dirname(__FILE__) + '/matcher/parser_matcher'

BLOG_PATH = File.dirname(__FILE__) + '/asset/blog.html'
ALTERNATE_PATH = File.dirname(__FILE__) + '/asset/alternate.html'

Spec::Runner.configure do |config|
  config.include(ParserMatcher)
end
