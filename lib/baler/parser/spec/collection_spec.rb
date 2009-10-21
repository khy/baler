require File.dirname(__FILE__) + '/spec_helper'

shared_examples_for 'a parser collection' do
end

describe Baler::Parser::Collection do
  def raw_collection(path = 'div.comment')
    Hpricot(open(BLOG_PATH)).search(path)
  end
  
  def proxy_collection(path = 'div.comment')
    adapter_document = Baler::Parser::Adapter::Hpricot::Document.new(BLOG_PATH)
    proxy_document = Baler::Parser::Document.new(adapter_document)
    proxy_collection = proxy_document.search(path)
  end
  
  it_should_behave_like 'a parser collection'
end
