require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/abstract_spec'

describe Baler::Parser::Hpricot do
  before(:each) do
    @source = Baler::Remote::Source.new(mock('class'), 'jah.com')
    @parser = Baler::Parser::Hpricot.new(@source)
    
    #mock out the Hpricot call for everything
    @doc = mock('doc')
    @parser.should_receive(:doc).any_number_of_times.and_return(@doc)
  end
  
  it_should_behave_like 'an abstract parser'
  
  describe '#value_for' do
    it 'should return nothing if no element exists for the mapping path' do
      @doc.should_receive(:search).once.and_return([])
      @parser.value_for('html > body > h1').should be_nil
    end
    
    it 'should return a single inner_html if only one element is found' do
      context_element, value_element = mock('element'), mock('element')
      context_element.should_receive(:search).with('html > body > h1').and_return([value_element])
      @doc.should_receive(:search).once.and_return([context_element])
      value_element.should_receive(:inner_html).once.and_return('delicious')
      @parser.value_for('html > body > h1').should == 'delicious'
    end
    
    it 'should return an array of inner_html values if multiple elements are found' do
      context_element, value_element1, value_element2 = Array.new(3){|i| mock('element')}
      context_element.should_receive(:search).with('html > body > h1').and_return([value_element1, value_element2])
      @doc.should_receive(:search).once.and_return([context_element])
      value_element1.should_receive(:inner_html).once.and_return('delicious')
      value_element2.should_receive(:inner_html).once.and_return('disgusting')
      @parser.value_for('html > body > h1').should == ['delicious', 'disgusting']
    end
    
    it 'should search within the source\'s context' do
      @source.set_context 'html > body'
      context_element = mock('element')
      @doc.should_receive(:search).once.with('html > body').and_return([context_element])
      context_element.should_receive(:search).once.with('h1').and_return([])
      @parser.value_for('h1')
    end
    
    it 'should reference the specified context' do
      context_elements = [mock('element'), mock('element')]
      value_element = mock('element')
      context_elements[0].should_not_receive(:search)
      context_elements[1].should_receive(:search).with('html > body > h1').and_return([value_element])
      @doc.should_receive(:search).once.and_return(context_elements)
      value_element.should_receive(:inner_html).once.and_return('delicious')
      @parser.value_for('html > body > h1', 1).should == 'delicious'
    end
    
    it 'should handle a path that includes the context' do
      @source.set_context 'html > body'
      context_element = mock('element')
      @doc.should_receive(:search).once.with('html > body').and_return([context_element])
      context_element.should_receive(:search).once.with('> h1').and_return([])
      @parser.value_for('html > body > h1')
    end
  end
end