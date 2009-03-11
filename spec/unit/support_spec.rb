require File.dirname(__FILE__) + '/../spec_helper'

describe Baler::Support::Hash do
  describe '#compose(other_hash)' do
    it 'should return a new hash reflecting the composition mapping of the two hashes' do
      hash1 = {1 => :a, 2 => :b}
      hash2 = {:a => 3, :b => 4}
      hash1.compose(hash2).should == {1 => 3, 2 => 4}
    end
    
    it 'should return a hash with only keys that appear in the calling hash' do
      hash1 = {1 => :a, 2 => :b}
      hash2 = {:a => 3, :b => 4, :c => 5}
      hash1.compose(hash2).should == {1 => 3, 2 => 4}
    end
    
    it 'should map keys to nil if there is not a corresponding key for the value in the argument hash' do
      hash1 = {1 => :a, 2 => :b}
      hash2 = {:a => 3}
      hash1.compose(hash2).should == {1 => 3, 2 => nil}
    end
  end
  
  describe '#compose!' do
    it 'should delegate to #compose' do
      hash1 = {1 => :a, 2 => :b}
      hash2 = {:a => 3, :b => 4}
      hash1.should_receive(:compose).with(hash2).and_return({1 => 3, 2 => 4})
      hash1.compose!(hash2)
    end
      
    it 'should build the composition in place' do
      hash1 = {1 => :a, 2 => :b}
      hash2 = {:a => 3, :b => 4}
      hash1.compose!(hash2)
      hash1.should == {1 => 3, 2 => 4}
    end
  end
end

describe Baler::Support::Array do
  describe '#element_or_array' do
    it 'should return the array if it has more than one element' do
      [1,2].element_or_array.should == [1,2]
    end
    
    it 'should return the element if it is the only one in the array' do
      [1].element_or_array.should == 1
    end
  
    it 'should return nil if the array is empty' do
      [].element_or_array.should be_nil
    end
  end
end