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
  
  describe '#relative_path' do
    it 'should return path if its source does not have a context' do
      @source.set_context nil
      @mapping.path = 'html > body > ol > li > h1'
      @mapping.relative_path.should == 'html > body > ol > li > h1'
    end
    
    it 'should return path if it does not begin with its source\'s context' do
      @source.set_context 'html > body > ol > li'
      @mapping.path = 'h1'
      @mapping.relative_path.should == 'h1'
    end
    
    it 'should return descendant selector in path if it includes its source\'s context' do
      @source.set_context 'html > body > ol > li'
      @mapping.path = 'html > body > ol > li h1'
      @mapping.relative_path.should == 'h1'
    end
  end
  
  describe '#absolute_path' do
    it 'should return path if source does not have a context' do
      @source.set_context nil
      @mapping.path = 'html > body > ol > li > h1'
      @mapping.absolute_path.should == 'html > body > ol > li > h1'
    end
    
    it 'should return path if it includes the source\'s context' do
      @source.set_context 'html > body > ol > li'
      @mapping.path = 'html > body > ol > li > h1'
      @mapping.absolute_path.should == 'html > body > ol > li > h1'
    end
    
    it 'should return context with path if path does not include context' do
      @source.set_context 'html > body > ol > li'
      @mapping.path = '> h1'
      @mapping.absolute_path.should == 'html > body > ol > li > h1'
    end
  end
  
  describe '#value' do
    it 'should call #value_for on source' do
      @source.should_receive(:value_for).once.with(@mapping)
      @mapping.value
    end
  end
end