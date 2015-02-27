class RenameImageIdToPictureId < ActiveRecord::Migration
  def change
    rename_column :pictures_squats, :image_id, :picture_id
  end
end
