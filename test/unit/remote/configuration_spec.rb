require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Remote::Configuration do
  describe 'after initialization, without specifying parser' do
    it 'should have the default parser' do
      configuration = Baler::Remote::Configuration.new
      configuration.parser_name.should == Baler::Remote::Configuration::DEFAULT_PARSER_NAME
    end
  end
  
  describe 'after initialization, with specified parser' do
    it 'should raise Parser::InvalidOptionError if parser is invalid' do
      Baler::Parser::OPTIONS[:invalid_parser].should be_nil
      lambda{Baler::Remote::Configuration.new(:invalid_parser)}.should raise_error(Baler::Parser::InvalidNameError)
    end
      
    it 'should have the specified parser, if valid' do
      Baler::Parser::OPTIONS[:hpricot].should_not be_nil
      configuration = Baler::Remote::Configuration.new(:hpricot)
      configuration.parser_name.should == :hpricot
    end
  end
end
    