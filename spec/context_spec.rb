require File.dirname(__FILE__) + '/spec_helper'

class ContextGame
  include Baler
  
  attr_accessor :date, :home_team, :home_score, :mvp
    
  set_remote_source File.dirname(__FILE__) + '/samples/game.html' do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :date => '> span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => 'ol > span.score.home'
  end
end

describe 'Baler context functionality' do
  before(:each) do
    @game = ContextGame.new
  end
  
  describe '#gather' do
    it 'should assign attributes data relative to the specified context' do
      @game.gather
      @game.date.should == 'Tuesday, February 3rd'
    end
    
    it 'should assign attributes even if an absolute path is given with a context' do
      @game.gather
      @game.home_team.should == 'Los Angeles Lakers'
    end
    
    it 'should assign nil to attributes mapped to nonexistant data' do
      @game.home_score = 112
      @game.gather
      @game.home_score.should be_nil
    end
    
    it 'shouldn\'t have any affect on unmapped attributes' do
      @game.mvp = 'Dwight Howard'
      @game.gather
      @game.mvp.should == 'Dwight Howard'
    end
  end
end