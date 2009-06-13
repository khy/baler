require File.dirname(__FILE__) + '/spec_helper'

class MultipleSourceSpec
  include Baler
  
  attr_accessor :league, :season
  
  set_remote_source :main => (ASSET_BASE + '/parser/game.html') do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :league => 'h1.global.league', :use_context => false
    source.map :season => 'h1.global.season', :use_context => false
  end
  
  set_remote_source :alternate => (ASSET_BASE + '/parser/alternate.html') do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :league => 'h1.global.league', :use_context => false
    source.map :season => 'h1.global.season', :use_context => false
  end
end

describe 'A class that mixes-in Baler' do
  before(:each) do
    @game = MultipleSourceSpec.new
  end
  
  context 'upon #gather' do
    it 'should gather the source corresponding to the supplied name' do
      @game.gather :main
      @game.league.should == "National Basketball Association"
      @game.season.should == "2008-09"
      
      @game.gather :alternate
      @game.league.should == "Major League Baseball"
      @game.season.should == "1996"
    end
  end
end