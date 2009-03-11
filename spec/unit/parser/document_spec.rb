require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Parser::Document do
  describe '#for' do
    it 'should return a new document instance based upon the TYPE_MAP hash' do
      Baler::Parser::Document::TYPE_MAP[:hpricot].should == Baler::Parser::Document::Hpricot
      Baler::Parser::Document::Hpricot.should_receive(:new).with('jah.com', 'html > body > h1')
      Baler::Parser::Document.for(:hpricot, 'jah.com', 'html > body > h1')
    end
  end
end