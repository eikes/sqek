class RenameImagesTableToPictures < ActiveRecord::Migration[4.2]
  def change
    rename_table :images, :pictures
  end
end
