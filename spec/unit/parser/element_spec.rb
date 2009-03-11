require File.dirname(__FILE__) + '/../../spec_helper'

describe Baler::Parser::Element do
  describe '#for' do
    it 'should return a new element instance based upon the TYPE_MAP and CLASS_TYPE_MAP hashes' do
      raw_element = mock('raw_element', :class => Hpricot::Elem)
      Baler::Parser::Element::TYPE_MAP[:hpricot].should == Baler::Parser::Element::Hpricot
      Baler::Parser::Element::CLASS_TYPE_MAP[Hpricot::Elem].should == :hpricot
      Baler::Parser::Element::Hpricot.should_receive(:new).with(raw_element)
      Baler::Parser::Element.for(raw_element)
    end
  end
end