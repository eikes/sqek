class RenameImageColumnInPicturesToPicture < ActiveRecord::Migration
  def change
    rename_column :pictures, :image, :picture
  end
end
