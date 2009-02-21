require File.dirname(__FILE__) + '/../spec_helper'

class Example
  include Baler
end

describe Baler do
  before(:each) do
    @example = Example.new
  end
  
  describe 'when included by a class' do
    it 'should add the class method Baler::Base:ClassMethods#set_remote_source' do
      Example.should respond_to(:set_remote_source)
    end
  
    it 'should add the class attribute Baler::Base:ClassMethods#remote_source' do
      Example.should respond_to(:remote_source)
    end
  
    it 'should add the instance method Baler::Base:InstanceMethods#gather' do
      @example.should respond_to(:gather)
    end
  
    it 'should add the instance method Baler::Base:InstanceMethods#harvest' do
      @example.should respond_to(:gather)
    end
  end
end

describe Baler::Base::ClassMethods do
  describe '#set_remote_source' do
    it 'should set the remote source to the specified URL' do
      Example.set_remote_source 'jah.com'
      Example.remote_source.url.should == "jah.com"
    end
    
    it 'should yield a Remote::Source instance' do
      Example.set_remote_source 'jah.com' do |remote_source|
        remote_source.should be_a_kind_of(Baler::Remote::Source)
      end
    end
  end
  
  describe '#remote_source' do
    it 'should return the same Remote::Source instance yielded by #set_remote_source' do
      @remote_source = nil
      Example.set_remote_source 'jah.com' do |remote_source|
        @remote_source = remote_source
      end
      Example.remote_source.should == @remote_source
    end
  end
end

describe Baler::Base::InstanceMethods do
  before(:each) do
    @example = Example.new
  end
  
  describe '#gather' do
    it 'should return the instance on which it is being called' do
      @example.gather.should == @example
    end
    
    it 'should, for each of its class\'s remote source mappings, 
        assign the value to the associated attribute' do
      remote_source = stub('remote_source', :mappings => [
        stub('mapping', :attribute => 'apple', :value => 'rotten'), 
        stub('mapping', :attribute => 'pear', :value => 'delicious')
      ])
      Example.should_receive(:remote_source).and_return(remote_source)
      @example.should_receive(:apple=).with('rotten')
      @example.should_receive(:pear=).with('delicious')
      @example.gather
    end
  end
end


    
    