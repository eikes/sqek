class RenameImageIdToPictureId < ActiveRecord::Migration[4.2]
  def change
    rename_column :pictures_squats, :image_id, :picture_id
  end
end
