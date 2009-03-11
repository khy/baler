require File.dirname(__FILE__) + '/../spec_helper'

describe Baler::Parser do
  before(:each) do
    @source = Baler::Remote::Source.new(mock('class'), 'jah.com')
    @parser = Baler::Parser.new(@source)
  end
  
  describe 'after initialization' do
    it 'should reference the specified source' do
      @parser.source.should == @source
    end
  end
  
  describe '#type' do
    it 'should return the default if not specified' do
      @parser.type.should == Baler::Parser::DEFAULT_TYPE
    end
  end
  
  describe '#type=(type)' do
    it 'should set the specified type' do
      @parser.type = :hpricot
      @parser.type.should == :hpricot
    end
    
    it 'should raise an error if the parser type is not supported' do
      Baler::Parser::TYPES.should_not include(:invalid_parser)
      lambda{@parser.type = :invalid_parser}.should raise_error(Baler::Parser::InvalidTypeError)
    end
  end
  
  describe '#document' do
    it 'should call Baler::Parser::Document.for with the appropriate arguments' do
      @parser.type = :hpricot
      Baler::Parser::Document.should_receive(:for).with(:hpricot, 'jah.com', nil)
      @parser.document
    end
  end
end

      