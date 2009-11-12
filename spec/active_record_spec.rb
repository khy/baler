require File.dirname(__FILE__) + '/spec_helper'
require ACTIVE_RECORD_PATH

class Game < ActiveRecord::Base
  include Baler
  
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'

    source.set_lookup :date, :home_team_name, :away_team_name do |instance|
      Game.find(:first, :conditions => {:date => instance.date, :home_team_name => instance.home_team_name,
        :away_team_name => instance.away_team_name})
    end
    
    source.map :date => 'span.date' do |result|
      result.first.inner_html.to_datetime
    end
    source.map :home_team_name => 'span.team.home'
    source.map :away_team_name => 'span.team.away'
    source.map :home_score => 'span.score.home'
    source.map :away_score => 'span.score.away'
  end

  set_remote_source :secondary => GAME_PATH do |source|
    source.set_context 'html > body > ol > li'

    source.set_lookup :date, :home_team_name, :away_team_name do |instance|
      Game.first
    end

    source.map :home_team_name => '' do |result|
      'Jah Jah Jock Straps'
    end
  end
end

describe 'A class that mixes-in Baler' do
  before(:each) do
    @existing_game_1 = Game.find(1) #LA vs ORL, 02/03 (match in game.html)
    @existing_game_2 = Game.find(2) #NYK vs DET, 03/05 (no match in game.html)
  end
  
  context 'upon .build_or_update' do
    it 'should return an array' do
      Game.build_or_update.should be_a_kind_of(Array)
    end
    
    it 'should include any existing instances match the returned instances' do
      games = Game.build_or_update
      games.should include(@existing_game_1)
    end
    
    it 'should not include any existing instances that do not match the returned instances' do
      Game.build_or_update.should_not include(@existing_game_2)
    end
    
    it 'should create new instances for non matching lookup values' do
      (Game.build_or_update - [@existing_game_1]).each do |game|
        game.should be_a_new_record
      end
    end

    it 'should reference include any instance returned by the lookup block' do
      first_game = Game.first
      Game.build_or_update(:secondary).each do |game|
        game.id.should == first_game.id
      end
    end

    it 'should gather from the same remote source at all times' do
      first_game = Game.first
      Game.build_or_update(:secondary).each do |game|
        game.home_team_name.should == 'Jah Jah Jock Straps'
      end
    end
  end
end