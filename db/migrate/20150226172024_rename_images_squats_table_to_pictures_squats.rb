class RenameImagesSquatsTableToPicturesSquats < ActiveRecord::Migration
  def change
    rename_table :images_squats, :pictures_squats
  end
end
