class AddPublishedToSquat < ActiveRecord::Migration
  def change
    add_column :squats, :published, :boolean
  end
end
