require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/abstract_spec'

describe Baler::Parser::Hpricot do
  before(:each) do
    @source = Baler::Remote::Source.new('jah.com')
    @parser = Baler::Parser::Hpricot.new(@source)
    
    #mock out the Hpricot call for everything
    @doc = mock('doc')
    @parser.should_receive(:doc).any_number_of_times.and_return(@doc)
  end
  
  it_should_behave_like 'an abstract parser'
  
  describe '#value_for' do
    before(:each) do
      @mapping = Baler::Remote::Mapping.new(@source, :apple, 'html > body > h1')
    end
      
    it 'should return nothing if no element exists for the mapping path' do
      @doc.should_receive(:at).once.with('html > body > h1').and_return(nil)
      @parser.value_for(@mapping).should be_nil
    end
    
    it 'should return inner_html of the found element' do
      element = mock('element')
      @doc.should_receive(:at).once.with('html > body > h1').and_return(element)
      element.should_receive(:inner_html).once.and_return('delicious')
      @parser.value_for(@mapping).should == 'delicious'
    end
  end
end