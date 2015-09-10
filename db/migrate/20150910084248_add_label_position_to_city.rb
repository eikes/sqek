class AddLabelPositionToCity < ActiveRecord::Migration
  def change
    add_column :cities, :label_position, :integer
    City.update_all label_position: 0
  end
end
