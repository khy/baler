require File.dirname(__FILE__) + '/spec_helper'

class BasicGame
  include Baler
  
  attr_accessor :date, :home_team, :home_score, :mvp
    
  set_remote_source File.dirname(__FILE__) + '/samples/game.html' do |source|
    source.uses :hpricot
    
    source.map :date => 'html > body > ol > li > span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => 'html > body > ol > li.nonexistant_class'
  end
end

describe 'basic Baler functionality' do
  before(:each) do
    @game = BasicGame.new
  end

  describe '#gather' do
    it 'should assign the data mapped to the attributes, where it exists' do
      @game.gather
      @game.date.should == 'Tuesday, February 3rd'
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
    