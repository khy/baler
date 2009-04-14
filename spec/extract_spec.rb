require File.dirname(__FILE__) + '/spec_helper'

class ExtractGame
  include Baler
  
  attr_accessor :a, :b, :c, :d
  
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'
    
    home_team1 = source.extract 'span.team.home'
    home_team2 = source.extract 'span.team.home', 2
    globals = source.extract 'h1.global', :context => false
    season = source.extract 'h1.global', 1, :context => false
        
    source.map :a => 'span.date' do |result|
      "#{result}...#{home_team1}"
    end
    
    source.map :b => 'span.team.away' do |result|
      home_team2
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
    it 'should return the value from the first context, if one isn\'t specified' do
      @game.gather
      @game.a.should == 'Tuesday, February 3rd...Los Angeles Lakers'
    end
    
    it 'should return the value from the specified context' do
      @game.gather
      @game.b.should == 'Memphis Grizzlies'
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
      @game.gather
      @game.a.should == 'Tuesday, February 3rd...Los Angeles Lakers'
      @game.gather(2)
      @game.a.should == 'Friday, February 6th...Los Angeles Lakers'
    end
  end
end