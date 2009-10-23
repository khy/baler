require File.dirname(__FILE__) + '/spec_helper'

class StandardBlockGame
  include Baler
  
  attr_accessor :away_team, :away_score, :referees, :away_wins, :away_losses
    
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :away_team =>  'span.team.away' do |result|
      result.first.inner_html.split.last
    end
    
    source.map :away_score => 'span.score.grrrrrr' do |result|
      result.first.inner_html.to_i
    end
    
    source.map :referees => 'ul.referees > li' do |result|
      result.map{|element| element.inner_html}.join
    end
    
    source.map :away_wins => 'span.team.away' do |result|
      result.first.attribute(:record).split('-')[0].to_i
    end
    
    source.map :away_losses => 'span.team.away' do |result|
      result.first.attribute(:record).split('-')[1].to_i
    end
  end
end

describe 'A class that mixes-in Baler' do
  before(:each) do
    @game = StandardBlockGame.new
  end
  
  context 'upon #gather' do
    it 'should supply the result of the selector to the specified block' do
      @game.gather
      @game.away_team.should == 'Magic'
      @game.referees.should == 'Joe CrawfordDick Bavetta'
    end
    
    it 'should set the mapped attribute to nil if the mapped element does not exist' do
      @game.gather
      @game.away_score.should be_nil
    end
    
    it 'should provide targeted elements based upon the supplied index' do
      @game.gather :index => 1
      @game.away_team.should == 'Pistons'
      @game.referees.should be_nil
    end
    
    it 'should give an array of elements that provide access to their attributes' do
      @game.gather
      @game.away_wins.should == 22
      @game.away_losses.should == 29
    end
  end
end