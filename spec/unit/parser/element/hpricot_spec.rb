require File.dirname(__FILE__) + '/../../../spec_helper'
require File.dirname(__FILE__) + '/abstract_spec'

describe Baler::Parser::Element::Hpricot do
  before(:each) do
    @raw_element = mock('raw_element')
    @element = Baler::Parser::Element::Hpricot.new(@raw_element)
  end
  
  it_should_behave_like 'an abstract parser element'
  
  describe '#inner_html' do
    it 'should call #inner_html on the raw element' do
      @raw_element.should_receive(:inner_html)
      @element.inner_html
    end
  end
  
  describe '#to_s' do
    it 'should be an alias for #inner_html' do
      @raw_element.should_receive(:inner_html).twice.and_return('jah')
      @element.to_s.should == @element.inner_html
    end
  end
  
  describe '#attribute_value(attribute)' do
    it 'should call #[attribute] on the raw element' do
      @raw_element.should_receive(:[]).with(:jah)
      @element.attribute_value(:jah)
    end
  end
  
  describe '#to_html' do
    it 'should call #to_html on the raw element' do
      @raw_element.should_receive(:to_html)
      @element.to_html
    end
  end
end