class Renamecolorcolumningamestable < ActiveRecord::Migration[5.0]
  def change
    rename_column :pieces, :color, :white
  end
end
