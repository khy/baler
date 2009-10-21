require File.dirname(__FILE__) + '/spec_helper'

shared_examples_for 'a parser element' do
end

describe Baler::Parser::Element do
  def hpricot_element(path = 'div.comments')
    Hpricot(open(BLOG_PATH)).at(path)
  end
  
  def proxy_element(path = 'div.comments')
    adapter_document = Baler::Parser::Adapter::Hpricot::Document.new(BLOG_PATH)
    proxy_document = Baler::Parser::Document.new(adapter_document)
    proxy_element = proxy_document.search(path)[0]
  end
  
  it_should_behave_like 'a parser element'
end