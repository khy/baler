require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Remote::Configuration do
  describe 'after initialization' do
    it 'should have the default parser' do
      source = mock('source')
      configuration = Baler::Remote::Configuration.new(source)
      configuration.source.should == source
    end
  end
end
    