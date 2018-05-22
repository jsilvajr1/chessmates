class AddCapturedToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :captured, :boolean
  end
end
