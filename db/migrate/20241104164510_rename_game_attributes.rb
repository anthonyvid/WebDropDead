class RenameGameAttributes < ActiveRecord::Migration[6.1]
  def change
    rename_column :games, :num_players, :number_of_players
    rename_column :games, :num_sides, :number_of_sides
    rename_column :games, :num_dice, :number_of_dice
  end
end