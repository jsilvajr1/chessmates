class AddNotcapturedToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :notcaptured, :boolean
  end
end
