require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'an abstract parser document', :shared => true do
  describe 'after initialization' do
    it 'should have the specified url' do
      @document.url == @url
    end
    
    it 'should have the specified context_path' do
      @document.context_path == @context_path
    end
  end
  
  it 'should implement #relative_elements_for' do
    @document.should respond_to(:relative_elements_for)
  end
  
  it 'should implement #absolute_elements_for' do
    @document.should respond_to(:absolute_elements_for)
  end
  
  it 'should implement #context_elements' do
    @document.should respond_to(:context_elements)
  end
end

describe Baler::Parser::Document::Abstract do
  before(:each) do
    @url = 'jah.com'
    @context_path = 'html > body > ol > li'
    @document = Baler::Parser::Document::Abstract.new(@url, @context_path)
  end
  
  it_should_behave_like 'an abstract parser document'
end