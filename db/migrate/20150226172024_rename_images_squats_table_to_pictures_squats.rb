class RenameImagesSquatsTableToPicturesSquats < ActiveRecord::Migration[4.2]
  def change
    rename_table :images_squats, :pictures_squats
  end
end
