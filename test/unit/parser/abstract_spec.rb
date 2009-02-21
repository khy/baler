require File.dirname(__FILE__) + '/../../spec_helper'

describe 'an abstract parser', :shared => true do
  describe 'after initialization' do
    it 'should have the specified source' do
      @parser.source.should == @source
    end
  end
end

describe Baler::Parser::Abstract do
  before(:each) do
    @source = Baler::Remote::Source.new('jah.com')
    @parser = Baler::Parser::Hpricot.new(@source)
  end
  
  it_should_behave_like 'an abstract parser'
end