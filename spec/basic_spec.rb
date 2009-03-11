require File.dirname(__FILE__) + '/spec_helper'

class BasicGame
  include Baler
  
  attr_accessor :date, :home_team, :visiting_team,
    :home_score, :visiting_score, :mvp
    
  set_remote_source File.dirname(__FILE__) + '/samples/game.html' do |source|
    source.uses :hpricot
    
    source.map :date => 'html > body > ol > li > span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => 'html > body > ol > li > span.score.home'
    source.map :mvp => 'html > body > ol > li.nonexistant_class'
  end
end

describe 'basic Baler setup' do
  before(:each) do
    @game = BasicGame.new
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
    it 'should have the mapped data after it is gathered' do
      @game.gather
      @game.home_score.should == '112'
    end
  end

  describe '#mvp' do
    it 'should have no value after it is gathered (since its mapped element is non-existant)' do
      @game.gather
      @game.mvp.should be_nil
    end
  end
end
    