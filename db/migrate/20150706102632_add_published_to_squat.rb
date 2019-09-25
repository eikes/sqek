class AddPublishedToSquat < ActiveRecord::Migration[4.2]
  def change
    add_column :squats, :published, :boolean
  end
end
