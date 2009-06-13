require File.dirname(__FILE__) + '/spec_helper'

class UrlMappingGame
  include Baler
  
  attr_accessor :league, :season
    
  set_remote_source(ASSET_BASE + '/parser/|filename|.html') do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :league => 'h1.global.league', :use_context => false
    source.map :season => 'h1.global.season', :use_context => false
  end
end

describe 'A class that mixes-in Baler' do
  before(:each) do
    @game = UrlMappingGame.new
  end
  
  context 'upon #gather' do
    it 'should resolve the url against the supplied pattern' do
      @game.gather :url_mapping => {'|filename|' => 'game'}
      @game.league.should == "National Basketball Association"
      @game.season.should == "2008-09"
      
      @game.gather :url_mapping => {'|filename|' => 'alternate'}
      @game.league.should == "Major League Baseball"
      @game.season.should == "1996"
    end
  end
end