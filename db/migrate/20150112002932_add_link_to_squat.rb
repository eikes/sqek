class AddLinkToSquat < ActiveRecord::Migration[4.2]
  def change
    add_column :squats, :link, :text
  end
end
