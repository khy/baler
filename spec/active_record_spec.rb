require File.dirname(__FILE__) + '/spec_helper'
require ACTIVE_RECORD_PATH

class Game < ActiveRecord::Base
  include Baler
  
  set_remote_source GAME_PATH do |source|
    source.set_context 'html > body > ol > li'
    source.set_lookup_attributes :date, :home_team_name, :away_team_name
    
    source.map :date => 'span.date' do |result|
      result.to_datetime
    end
    source.map :home_team_name => 'span.team.home'
    source.map :away_team_name => 'span.team.away'
    source.map :home_score => 'span.score.home'
    source.map :away_score => 'span.score.away'
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
    
    it 'should include any existing instances match the lookup values' do
      Game.build_or_update.should include(@existing_game_1)
    end
    
    it 'should not include any existing instances that do not match the lookup values' do
      Game.build_or_update.should_not include(@existing_game_2)
    end
    
    it 'should create new instances for non matching lookup values' do
      (Game.build_or_update - [@existing_game_1]).each do |game|
        game.should be_a_new_record
      end
    end
  end
end