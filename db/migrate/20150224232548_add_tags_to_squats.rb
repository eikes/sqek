class AddTagsToSquats < ActiveRecord::Migration
  def change
    add_column :squats, :tags, :text
  end
end
