require File.dirname(__FILE__) + '/spec_helper'

class ExtractGame
  include Baler
  
  attr_accessor :a, :b, :c, :d
  
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'
    
    home_team1 = source.extract 'span.team.home', :context => true
    home_team2 = source.extract 'span.team.home', 2, :context => true
    globals = source.extract 'h1.global'
    season = source.extract 'h1.global', 1
        
    source.map :a => 'span.date' do |result|
      home_team1
    end
    
    source.map :b => 'span.team.away' do |result|
      "#{result}...#{home_team2}"
    end
    
    source.map :c => 'span.score.away' do |result|
      globals
    end
    
    source.map :d => 'ul.referees > li' do |result|
      result.map{|element| "#{element}/#{season}"}
    end
  end
end

describe 'Baler extract functionality' do
  before(:each) do
    @game = ExtractGame.new
  end
  
  describe 'extract' do
    it 'should return the values across contexts, if one isn\'t specified' do
      @game.gather
      @game.a.should == ['Los Angeles Lakers', 'New York Knicks', 'Memphis Grizzlies']
    end
    
    it 'should return the value from the specified context' do
      @game.gather
      @game.b.should == 'Orlando Magic...Memphis Grizzlies'
    end
    
    it 'should ignore context when appropriate option is specified' do
      @game.gather
      @game.c.should == ['National Basketball Association', '2008-09']
    end
    
    it 'should ignore context when appropriate options is specified, and
          choose the specified index' do
      @game.gather
      @game.d.should == ['Joe Crawford/2008-09', 'Dick Bavetta/2008-09']
    end
    
    it 'should return a constant result, regardless of context' do
      @game.gather 0
      @game.b.should == 'Orlando Magic...Memphis Grizzlies'
      @game.gather 2
      @game.b.should == 'Boston Celtics...Memphis Grizzlies'
    end
  end
end