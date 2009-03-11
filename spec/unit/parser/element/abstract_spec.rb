require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'an abstract parser element', :shared => true do
  describe '#method_missing' do
    it 'should pass the method to #attribute_value' do
      @element.should_receive(:attribute_value).with(:jah)
      @element.jah
    end
  end
  
  it 'should implement #inner_html' do
    @element.should respond_to(:inner_html)
  end
  
  it 'should implement #to_s' do
    @element.should respond_to(:to_s)
  end
  
  it 'should implement #attribute_value' do
    @element.should respond_to(:attribute_value)
  end
  
  it 'should implement #to_html' do
    @element.should respond_to(:to_html)
  end
end

describe Baler::Parser::Element::Abstract do
  before(:each) do
    @raw_element = mock('raw_element')
    @element = Baler::Parser::Element::Abstract.new(@raw_element)
  end
  
  it_should_behave_like 'an abstract parser element'
end
