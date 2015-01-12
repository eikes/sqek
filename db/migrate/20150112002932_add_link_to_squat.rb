class AddLinkToSquat < ActiveRecord::Migration
  def change
    add_column :squats, :link, :text
  end
end
