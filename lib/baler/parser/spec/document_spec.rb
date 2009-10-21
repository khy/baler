require File.dirname(__FILE__) + '/spec_helper'

shared_examples_for 'a parser document' do
  context '#relative_elements_for(path, index = nil)' do
    it 'should return a Parser::Collection for the absolute path if no context element exists' do
      relative_elements_result = proxy_document.relative_elements_for('div#post')
      search_result = raw_document.search('div#post')
      relative_elements_result.should be_a(Baler::Parser::Collection)
      relative_elements_result.should match_underlying_html_of(search_result)
    end
    
    it 'should return a Parser::Collection of elements relative to the context path' do
      context_path = 'div.comment'
      document = proxy_document(context_path)
      relative_elements_result = document.relative_elements_for('span')
      search_result = proxy_document.search("#{context_path} span")
      relative_elements_result.should be_a(Baler::Parser::Collection)
      relative_elements_result.should match_underlying_html_of(search_result)
    end
    
    it 'should return a Parser::Collection of elements relative to the context path specified by the supplied index' do
      context_path = 'div.comment'
      document = proxy_document(context_path)
      relative_elements_result = document.relative_elements_for('span', 1)
      search_result = proxy_document.search("#{context_path}")[1].search('span')
      relative_elements_result.should be_a(Baler::Parser::Collection)
      relative_elements_result.should match_underlying_html_of(search_result)
    end
    
    it 'should return an empty Parser::Collection if the context matches nothing' do
      document = proxy_document('div.missing')
      relative_elements_result = document.relative_elements_for('span', 1)
      relative_elements_result.should be_a(Baler::Parser::Collection)
      relative_elements_result.should be_empty
    end
  end
  
  context '#absolute_elements_for(path, index = nil)' do
    it 'should return a Parser::Collection based upon the supplied path, without context' do
      absolute_elements_result = proxy_document.absolute_elements_for('div#post')
      search_result = raw_document.search('div#post')
      absolute_elements_result.should be_a(Baler::Parser::Collection)
      absolute_elements_result.should match_underlying_html_of(search_result)
    end
    
    it 'should return a Parser::Element for the specified index in the matching collection' do
      absolute_elements_result = proxy_document.absolute_elements_for('div.comment', 1)
      search_result = raw_document.search('div.comment')[1]
      absolute_elements_result.should be_a(Baler::Parser::Element)
      absolute_elements_result.should match_underlying_html_of(search_result)
    end
  end
  
  context '#context_element(index)' do
    it 'should return the specified element for the documents context path' do
      context_element_result = proxy_document('div.comment').context_element(1)
      search_result = proxy_document.search('div.comment')[1]
      context_element_result.should match_underlying_html_of(search_result)
    end
  end
  
  context '#context_size' do
    it 'should return the number of elements referenced by the context' do
      proxy_document('div.comment').context_size.should == proxy_document.search('div.comment').size
    end
  end
end

describe Baler::Parser::Document do
  context 'using Hpricot' do
    def raw_document
      Hpricot(open(BLOG_PATH))
    end

    def proxy_document(context_path = nil)
      adapter_document = Baler::Parser::Adapter::Hpricot::Document.new(BLOG_PATH)
      Baler::Parser::Document.new(adapter_document, context_path)
    end
  
    it_should_behave_like 'a parser document'
  end
end
