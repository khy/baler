class AddRecords < ActiveRecord::Migration
  class Game < ActiveRecord::Base; end
  
  def self.up
    Game.create(:date => 'Tuesday, February 3rd'.to_datetime, 
      :home_team_name => 'Los Angeles Lakers', :away_team_name => 'Orlando Magic',
      :home_score => 45, :away_score => 39)
      
    Game.create(:date => 'Wednesday, March 4th'.to_datetime, 
      :home_team_name => 'New York Knicks', :away_team_name => 'Detroit Pistons',
      :home_score => 86, :away_score => 76)
  end  
  
  def self.down  
    Game.destroy_all
  end  
end