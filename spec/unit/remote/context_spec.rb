require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Remote::Context do
  before(:each) do
    @source = mock('source')
    @context = Baler::Remote::Context.new(@source, 'html > body > h1')
  end
  
  describe 'after initialization' do
    it 'should have the specified source' do
      @context.source.should == @source
    end
    
    it 'should have the specified path' do
      @context.path.should == 'html > body > h1'
    end
  end
  
  describe '#elements' do
    it 'should delegate to the source\'s document' do
      @document = mock('document')
      @document.should_receive(:absolute_elements_for).with('html > body > h1')
      @source.should_receive(:document).and_return(@document)
      @context.elements
    end
  end
end