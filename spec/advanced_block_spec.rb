require File.dirname(__FILE__) + '/spec_helper'

class AdvancedBlockGame
  include Baler
  
  attr_accessor :year, :date
    
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :year => 'h1.global.season', :context => false
    
    source.map  :date => 'span.date' do |result, game|
      result.first.inner_html + ' ' + game.year
    end
  end
end

describe 'Baler advanced block functionality' do
  before(:each) do
    @game = AdvancedBlockGame.new
  end
  
  describe '#gather' do
    it 'should provide the instance to the map block if specified' do
      @game.gather(:index => 0).date.should == "Tuesday, February 3rd 2008-09"
    end
  end
end