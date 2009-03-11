require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Remote::Source do
  before(:each) do
    @source = Baler::Remote::Source.new(mock('class'), 'jah.com')
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
      Baler::Remote::Mapping.stub!(:new).and_return(new_mapping)
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
  
  describe '#gather' do
    it 'should return the specified instance' do
      @source.should_receive(:mappings).and_return([])
      instance = mock('class_instance')
      @source.gather(instance).should == instance
    end
    
    it 'should assign each mapping\'s value to its attribute of the instance' do
      mapping1 = mock('mapping', :attribute => :color, :value => 'red')
      mapping2 = mock('mapping', :attribute => :shape, :value => 'circle')
      @source.should_receive(:mappings).and_return([mapping1, mapping2])
      instance = mock('class_instance')
      instance.should_receive(:color=).with('red')
      instance.should_receive(:shape=).with('circle')
      @source.gather(instance)
    end
    
    it 'should reference the value for the specified context' do
      mapping = mock('mapping', :attribute => :color)
      mapping.should_receive(:value).with(1).and_return('red')
      @source.should_receive(:mappings).and_return([mapping])
      instance = mock('class_instance')
      instance.should_receive(:color=).with('red')
      @source.gather(instance, 1)
    end
  end
  
  describe '#build' do
    it 'should return an array' do
      @source.context.should_receive(:size).and_return(0)
      @source.build.should be_a_kind_of(Array)
    end
    
    it 'should return an array of gathered instances of the master class' do
      instance1 = mock('class_instance')
      instance1.should_receive(:gather).once.and_return(instance1)
      instance2 = mock('class_instance')
      instance2.should_receive(:gather).once.and_return(instance2)
      @source.master.should_receive(:new).twice.and_return(instance1, instance2)
      @source.context.should_receive(:size).and_return(2)
      @source.build.should == [instance1, instance2]
    end
  end
  
  describe '#set_context' do
    it 'should set the source\'s context attribute' do
      @source.set_context 'html > body > ol > li'
      @source.context.path.should == 'html > body > ol > li'
    end
  end

  describe '#uses(parser)' do
    it 'should set the parser\'s type attribute' do
      @source.parser.should_receive(:type=).with(:jah)
      @source.uses :jah
    end
  end
  
  describe '#parser' do
    it 'should return an instance of Baler::Parser' do
      @source.parser.should be_a_kind_of(Baler::Parser)
    end
    
    it 'should return a parser referencing the source' do
      @source.parser.source.should == @source
    end
  end
end