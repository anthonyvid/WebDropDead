class AddUserIdToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :user_id, :integer
    add_index :games, :user_id # This helps optimize queries for games by user
  end
end