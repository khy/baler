require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Remote::Source do
  before(:each) do
    @source = Baler::Remote::Source.new('jah.com')
  end
  
  describe 'after initialization' do
    it 'should return the specified url value' do
      @source.url.should == 'jah.com'
    end
    
    it 'should have no mappings' do
      @source.mappings.should be_empty
    end
    
    it 'should have a Baler::Remote::Configuration object' do
      @source.configuration.should be_a_kind_of(Baler::Remote::Configuration)
    end
    
    it 'should alias #configuration as #config' do
      @source.configuration.should === @source.config
    end
  end
  
  describe '#map(attribute_map)' do
    it 'should instantiate a new Baler::Remote::Mapping object' do
      Baler::Remote::Mapping.should_receive(:new)
      @source.map(:apple => 'html > base > h1')
    end
    
    it 'should add the new mapping to the source\'s mappings' do
      new_mapping = mock('mapping')
      Baler::Remote::Mapping.should_receive(:new).and_return(new_mapping)
      @source.map(:apple => 'html > base > h1')
      @source.mappings.should include(new_mapping)
    end
    
    it 'should accept a hash of multiple mappings' do
      Baler::Remote::Mapping.should_receive(:new).twice
      intial_mappings_amount = @source.mappings.length
      @source.map(:apple => 'html > base > h1.apple', :pear => 'html > base > h1.pear')
      @source.mappings.should have(intial_mappings_amount + 2).items
    end
    
    it 'should return the source\'s mappings' do
      @source.map(:apple => 'html > base > h1').should == @source.mappings
    end
  end
  
  describe '#value_for(mapping)' do
    it 'should delegate to the parser object' do
      @source.should_receive(:parser).any_number_of_times.and_return(mock('parser'))
      @source.parser.should_receive(:value_for).with(:apple).and_return('McIntosh')
      @source.value_for(:apple).should == 'McIntosh'
    end
  end
  
  describe '#uses(parser)' do
    it 'should set the config object\'s parser attribute' do
      @source.uses :jah
      @source.config.parser_name.should == :jah
    end
  end
  
  describe '#parser' do
    it 'should delegate to Baler::Parser.for' do
      Baler::Parser.should_receive(:for).with(@source)
      @source.parser
    end
  end
end