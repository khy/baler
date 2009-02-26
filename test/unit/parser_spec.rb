require File.dirname(__FILE__) + '/../spec_helper'

describe Baler::Parser do
  describe '.for' do
    before(:each) do
      @source = Baler::Remote::Source.new(mock('class'), 'jah.com')
    end
    
    it 'should return an instance of the parser corresponding to the name specified by the source' do
      Baler::Parser::OPTIONS[:hpricot].should == Baler::Parser::Hpricot
      @source.uses :hpricot
      Baler::Parser.for(@source).should be_an_instance_of(Baler::Parser::Hpricot)
    end
    
    it 'should return a parser with the specified source' do
      Baler::Parser.for(@source).source.should == @source
    end
  end
end

      