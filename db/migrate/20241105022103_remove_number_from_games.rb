class RemoveNumberFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :number, :integer
  end
end
