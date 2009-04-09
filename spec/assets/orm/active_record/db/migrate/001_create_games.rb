class CreateGames < ActiveRecord::Migration  
  def self.up  
    create_table :games do |t|
      t.datetime :date
      t.string :home_team_name
      t.string :away_team_name
      t.integer :home_score
      t.integer :away_score
    end  
  end  
  
  def self.down  
    drop_table :games
  end  
end