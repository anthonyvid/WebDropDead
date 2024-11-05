class AddNumberToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :number, :integer
  end
end
