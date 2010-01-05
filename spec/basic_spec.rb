require File.dirname(__FILE__) + '/spec_helper'

class BasicGame
  include Baler
  
  attr_accessor :date, :home_team, :home_score, :mvp
  
  set_remote_source GAME_PATH do |source|
    source.map :date => 'html > body > ol > li > span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => 'html > body > ol > li.nonexistant_class'
  end
end

describe 'A class that mixes-in Baler' do
  before(:each) do
    @game = BasicGame.new
  end

  context 'upon #gather' do
    it 'should assign the first value mapped to an attribute' do
      @game.gather
      @game.date.should == 'Tuesday, February 3rd'
      @game.home_team.should == 'Los Angeles Lakers'
    end
    
    it 'should assign nil to attributes mapped to a nonexistant value' do
      @game.home_score = 112
      @game.gather
      @game.home_score.should be_nil
    end
    
    it 'shouldn\'t have any affect on unmapped attributes' do
      @game.mvp = 'Dwight Howard'
      @game.gather
      @game.mvp.should == 'Dwight Howard'
    end
    
    it 'should gather only the specified attributes' do
      @game.home_score = 12
      @game.gather :attributes => [:date, :home_team]
      @game.date.should == 'Tuesday, February 3rd'
      @game.home_team.should == 'Los Angeles Lakers'
      @game.home_score.should == 12
    end
    
    it 'should assign the nth value mapped to the attributes, if index n is specified' do
      @game.gather :index => 0
      @game.date.should == 'Tuesday, February 3rd'
      @game.home_team.should == 'Los Angeles Lakers'
      
      @game.gather :index => 1
      @game.date.should == 'Wednesday, February 4th'
      @game.home_team.should == 'New York Knicks'
    end
    
    it 'should assign all the data mapped to the attributes, if index is explicitly false' do
      @game.gather :index => false
      @game.date.should == ['Tuesday, February 3rd', 'Wednesday, February 4th', 'Friday, February 6th']
      @game.home_team.should == ['Los Angeles Lakers', 'New York Knicks', 'Memphis Grizzlies']
    end
  end
end
 