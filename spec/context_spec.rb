require File.dirname(__FILE__) + '/spec_helper'

class ContextGame
  include Baler
  
  attr_accessor :global, :date, :home_team, :home_score, :mvp, :referees
    
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :global => 'h1.global', :use_context => false
    source.map :date => '> span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => 'ol > span.score.home'
    source.map :referees => '> ul.referees > li'
  end
end

class InvalidContextGame
  include Baler
  
  attr_accessor :date, :home_team
    
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li > jah'
    
    source.map :date => '> span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
  end  
end

describe 'A class that mixes-in Baler' do
  before(:each) do
    @game = ContextGame.new
  end
  
  context 'upon #gather' do
    it 'should assign values relative to the specified context' do
      @game.gather
      @game.date.should == 'Tuesday, February 3rd'
    end
    
    it 'should assign values absolutely if the selector begins with the specified context' do
      @game.gather
      @game.home_team.should == 'Los Angeles Lakers'
    end
    
    it 'should assign values relative to the context specified by the index' do
      @game.gather :index => 2
      @game.date.should == 'Friday, February 6th'
      @game.home_team.should == 'Memphis Grizzlies'
    end
    
    it 'should assign all data within a context to the mapped attribute' do
      @game.gather
      @game.referees.should == ['Joe Crawford', 'Dick Bavetta']
    end
    
    it 'should assign nil to attributes mapped to nonexistant data (relative to the specified context)' do
      @game.home_score = 112
      @game.gather
      @game.home_score.should be_nil
    end
    
    it 'should assign nil to attributes that don\'t exist in the specified context' do
      @game.referees = 'stub'
      @game.gather :index => 1
      @game.referees.should be_nil
    end
    
    it 'shouldn\'t have any affect on unmapped attributes' do
      @game.mvp = 'Dwight Howard'
      @game.gather
      @game.mvp.should == 'Dwight Howard'
    end
    
    it 'should assign nil to attributes for a non-existant context' do
      @invalid_game = InvalidContextGame.new
      @invalid_game.date = '1/2/09'
      @invalid_game.home_team = 'Orlando Magic'
      @invalid_game.gather
      @invalid_game.date.should be_nil
      @invalid_game.home_team.should be_nil
    end
    
    it 'should forgo the context if directed to' do
      @game.gather
      @game.global.should == ['National Basketball Association', '2008-09']
    end
  end
end