class CreateJoinTablesImageSquat < ActiveRecord::Migration[4.2]
  def change
    create_join_table :images, :squats do |t|
      # t.index [:image_id, :squat_id]
      # t.index [:squat_id, :image_id]
    end
  end
end
