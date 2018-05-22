class RemoveCapturedFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :captured, :boolean
  end
end
