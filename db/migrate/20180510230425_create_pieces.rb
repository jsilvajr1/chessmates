class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.integer :location_x
      t.integer :location_y
      t.string :picture
      t.boolean :color #not sure about this one. look up boolean color

      t.timestamps
    end
  end
end
