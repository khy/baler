require File.dirname(__FILE__) + '/../../../spec_helper'
require File.dirname(__FILE__) + '/abstract_spec'

describe Baler::Parser::Document::Hpricot do
  before(:each) do
    @url = 'jah.com'
    @context_path = 'html > body > ol > li'
    @document = Baler::Parser::Document::Hpricot.new(@url, @context_path)
    
    #mock out the Hpricot call for everything
    @raw_document = mock('raw_document')
    @document.should_receive(:raw_document).any_number_of_times.and_return(@raw_document)
  end
  
  it_should_behave_like 'an abstract parser document'
  
  describe '#relative_elements_for(path, context_index = 0)' do
    it 'should return an empty array if no context elements exist' do
      @document.should_receive(:context_elements).once.and_return([])
      @document.relative_elements_for('> h1').should be_empty
    end
    
    it 'should return an array of baler elements if any are found' do
      context_element, value_element = mock('raw_element'), mock('raw_element')
      context_element.should_receive(:search).with('html > body > h1').and_return([value_element])
      baler_element = mock('baler_element')
      Baler::Parser::Element.should_receive(:for).with(value_element).and_return(baler_element)
      @document.should_receive(:context_elements).once.and_return([context_element])
      @document.relative_elements_for('html > body > h1').should == [baler_element]
    end
    
    it 'should search within the source\'s context' do
      context_elements = [mock('raw_element'), mock('raw_element')]
      @document.should_receive(:context_elements).once.and_return(context_elements)
      context_elements[0].should_not_receive(:search)
      context_elements[1].should_receive(:search).once.with('h1').and_return([])
      @document.relative_elements_for('h1', 1)
    end
  end
  
  describe '#absolute_elements_for(path)' do
    it 'should delegate to the document' do
      @raw_document.should_receive(:search).with('html > body > h1')
      @document.absolute_elements_for('html > body > h1')
    end
  end
  
  describe '#context_elements' do
    it 'should delegate to the document' do
      @raw_document.should_receive(:search).with(@context_path)
      @document.context_elements
    end
  end
end