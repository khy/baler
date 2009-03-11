require File.dirname(__FILE__) + '/spec_helper'

class ContextGame
  include Baler
  
  attr_accessor :date, :home_team, :visiting_team,
    :home_score, :visiting_score, :mvp
    
  set_remote_source File.dirname(__FILE__) + '/samples/game.html' do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :date => '> span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => 'ol > span.score.home'
  end
end

describe 'Baler setup with context' do
  before(:each) do
    @game = ContextGame.new
  end
  
  describe 'after initialization' do
    it 'should have no attributes with a value' do
      @game.date.should be_nil
      @game.home_team.should be_nil
      @game.home_score.should be_nil
      @game.mvp.should be_nil
    end
  end
  
  describe '#date' do
    it 'should have the mapped data after it is gathered' do
      @game.gather
      @game.date.should == 'Tuesday, February 3rd'
    end
  end

  describe '#home_team' do
    it 'should have the mapped data after it is gathered' do
      @game.gather
      @game.home_team.should == 'Los Angeles Lakers'
    end
  end

  describe '#home_score' do
    it 'should have no data after it is gathered (since its mapped element is non-existant)' do
      @game.gather
      @game.home_score.should be_nil
    end
  end
end