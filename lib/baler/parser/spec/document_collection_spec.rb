require File.dirname(__FILE__) + '/spec_helper'

shared_examples_for 'a parser document collection' do
  context 'relative_elements_for(path, index = nil)' do
    it 'should return a Parser::Collection object' do
      Baler::Parser::Document::Collection.new(proxy_documents('div.comment')).
        relative_elements_for('span').should be_a_kind_of Baler::Parser::Collection
    end

    it 'should return a concatenation of the the relative elements for the member documents' do
      documents = proxy_documents('div.comment')
      document_collection = Baler::Parser::Document::Collection.new(documents)
      
      combined_elements = documents.map do |document|
        document.relative_elements_for('span')
      end.inject{|result, elements| result + elements}

      collection_elements = document_collection.relative_elements_for('span')
      
      combined_elements.length.should == collection_elements.length
      collection_elements.each do |element|
        combined_elements.should include(element)
      end
    end
  end

  context 'absolute_elements_for(path, index = nil)' do
    it 'should return a Parser::Collection object' do
      Baler::Parser::Document::Collection.new(proxy_documents('div.comment')).
        absolute_elements_for('span').should be_a_kind_of Baler::Parser::Collection
    end

    it 'should return a concatenation of the the relative elements for the member documents' do
      documents = proxy_documents('div.comment')
      document_collection = Baler::Parser::Document::Collection.new(documents)

      combined_elements = documents.map do |document|
        document.absolute_elements_for('span')
      end.inject{|result, elements| result + elements}

      collection_elements = document_collection.absolute_elements_for('span')

      combined_elements.length.should == collection_elements.length
      collection_elements.each do |element|
        combined_elements.should include(element)
      end
    end
  end

  context 'context_paths' do
    it 'should return an array of all the member documents\' context paths' do
      adapters = proxy_adapters
      documents = [Baler::Parser::Document.new(adapters[0], 'div.header'),
                   Baler::Parser::Document.new(adapters[1], 'div.post')]
      Baler::Parser::Document::Collection.new(documents).context_paths.each do |path|
        ['div.header', 'div.post'].should include(path)
      end
    end
  end

  context 'context_path' do
    it 'should return one of the member document\'s context paths' do
      adapters = proxy_adapters
      documents = [Baler::Parser::Document.new(adapters[0], 'div.header'),
                   Baler::Parser::Document.new(adapters[1], 'div.post')]
      path = Baler::Parser::Document::Collection.new(documents).context_path
      ['div.header', 'div.post'].should include(path)
    end
  end

  context 'context_size' do
    it 'should return a sum of the member documents\' context sizes' do
      documents = proxy_documents('div.comment')
      document_collection = Baler::Parser::Document::Collection.new(documents)

      combined_context_size = documents.inject(0){|total, document| total + document.context_size}
      document_collection.context_size.should == combined_context_size
    end
  end
end

describe Baler::Parser::Document::Collection do
  context 'using Hpricot' do
    def proxy_adapters
      [BLOG_PATH, ALTERNATE_PATH].map{|path| Baler::Parser::Adapter::Hpricot::Document.new(path)}
    end

    def proxy_documents(context_path = nil)
      proxy_adapters.map do |adapter|
        Baler::Parser::Document.new(adapter, context_path)
      end
    end

    it_should_behave_like 'a parser document collection'
  end
end