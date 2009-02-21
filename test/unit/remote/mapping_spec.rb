require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Remote::Mapping do
  before(:each) do
    @source = Baler::Remote::Source.new('jah.com')
    @mapping = Baler::Remote::Mapping.new(@source, :apple, 'html > body > h1')
  end
  
  describe 'after initialization' do
    it 'should have the specified source' do
      @mapping.source.should == @source
    end
    
    it 'should have the specified attribute' do
      @mapping.attribute.should == :apple
    end
    
    it 'should have the specified path' do
      @mapping.path.should == 'html > body > h1'
    end
  end
  
  describe '#value' do
    it 'should call #value_for on source' do
      @source.should_receive(:value_for).once.with(@mapping)
      @mapping.value
    end
  end
end