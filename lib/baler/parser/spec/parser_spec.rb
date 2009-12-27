require File.dirname(__FILE__) + '/spec_helper'

describe Baler::Parser do
  context '#document' do
    it 'should return a Parser::Document if a single URL is specified' do
      Baler::Parser.document(:hpricot, 'jah.com').should be_kind_of(Baler::Parser::Document)
    end
    
    it 'should return a Parser::Document with a stub adapter' do
      Baler::Parser.document(mock(:document_adapter)).should be_kind_of(Baler::Parser::Document)
    end
    
    it 'should return a document with specified context_path accessible' do
      Baler::Parser.document(:hpricot, 'jah.com', 'html h1.title').context_path.should == 'html h1.title'
    end

    it 'should return a Parser::Document with a stub adapter and the specified context_path' do
      Baler::Parser.document(mock(:document_adapter), 'html h1.title').context_path.should == 'html h1.title'
    end

    it 'should return a Parser::Document::Collection if an array of URLs are specified' do
      Baler::Parser.document(:hpricot, ['jah.com', 'blah.com']).should be_kind_of(Baler::Parser::Document::Collection)
    end

    it 'should return a Parser::Document::Collection if an array of adapters are specified' do
      Baler::Parser.document([mock(:document_adapter), mock(:document_adapter)]).
        should be_kind_of(Baler::Parser::Document::Collection)
    end

    it 'should return a Parser::Document::Collection if an array of URLs are specified with the specifed context_path' do
      Baler::Parser.document(:hpricot, ['jah.com', 'blah.com'], 'html h1.title').context_path.should == 'html h1.title'
    end

    it 'should return a Parser::Document::Collection if an array of adapters are specified with the specifed context_path' do
      Baler::Parser.document([mock(:document_adapter), mock(:document_adapter)], 'html h1.title').
        context_path.should == 'html h1.title'
    end
  end
end