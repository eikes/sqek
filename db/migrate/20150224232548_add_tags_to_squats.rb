class AddTagsToSquats < ActiveRecord::Migration[4.2]
  def change
    add_column :squats, :tags, :text
  end
end
