class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :num_players
      t.integer :num_sides
      t.integer :num_dice
      t.datetime :started_at

      t.timestamps
    end
  end
end
