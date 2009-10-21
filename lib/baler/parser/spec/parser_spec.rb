require File.dirname(__FILE__) + '/spec_helper'

describe Baler::Parser do
  context '#document' do
    it 'should return a Parser::Document' do
      Baler::Parser.document(:hpricot, 'jah.com').should be_kind_of(Baler::Parser::Document)
    end
    
    it 'should return a Parser::Document with a stub adapter' do
      Baler::Parser.document(mock(:document_adapter), 'jah.com').should be_kind_of(Baler::Parser::Document)
    end
    
    it 'should return a document with specified context_path accessible' do
      Baler::Parser.document(:hpricot, 'jah.com', 'html h1.title').context_path.should == 'html h1.title'
    end
  end
end