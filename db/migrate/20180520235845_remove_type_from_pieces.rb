class RemoveTypeFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :type, :string
  end
end
