class AddSummaryToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :summary, :text
  end
end
