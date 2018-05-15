class AddWhiteBlackPlayersToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :white_player_id, :integer
    add_column :games, :black_player_id, :integer

    add_index :games, :black_player_id
    add_index :games, :white_player_id
  end
end
