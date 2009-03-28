require File.dirname(__FILE__) + '/spec_helper'

class BuildGame
  include Baler

  attr_accessor :league, :date, :home_team, :home_score, :mvp

  set_remote_source File.dirname(__FILE__) + '/samples/game.html' do |source|
    source.set_context 'html > body > ol > li'
    
    source.map :league => 'h1.global', :context => false
    source.map :date => '> span.date'
    source.map :home_team => 'html > body > ol > li > span.team.home'
    source.map :home_score => '> span.score.home'
  end
end

describe 'Baler build functionality' do
  describe '#build' do
    it 'should return an array' do
      BuildGame.build.should be_a_kind_of(Array)
    end
    
    it 'should return an element for each context in the source' do
      BuildGame.build.length.should == 3
    end
    
    it 'should return an array of instances of the master class' do
      BuildGame.build.each do |element|
        element.should be_a_kind_of(BuildGame)
      end
    end
    
    it 'should assign the data mapped to the attribute of the instance 
        corresponding to the context' do
      instances = BuildGame.build
      instances[0].home_score.should == "112"
      instances[1].home_team.should == "New York Knicks"
      instances[2].date.should == "Friday, February 6th"
    end
    
    it 'should assign the same data to attributes that do not use context' do
      instances = BuildGame.build
      instances[0].league.should == 'National Basketball Association'
      instances[1].league.should == 'National Basketball Association'
      instances[2].league.should == 'National Basketball Association'
    end
  end
end
    