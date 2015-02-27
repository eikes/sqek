class RenameImagesTableToPictures < ActiveRecord::Migration
  def change
    rename_table :images, :pictures
  end
end
