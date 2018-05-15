class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :game_id
      t.string :game_name
      t.timestamps
    end

    add_index :games, :game_id
  end
end
