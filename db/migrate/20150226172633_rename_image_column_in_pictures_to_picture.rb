class RenameImageColumnInPicturesToPicture < ActiveRecord::Migration[4.2]
  def change
    rename_column :pictures, :image, :picture
  end
end
