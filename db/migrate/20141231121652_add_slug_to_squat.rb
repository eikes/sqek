class AddSlugToSquat < ActiveRecord::Migration
  def change
    add_column :squats, :slug, :string
    add_index :squats, :slug, unique: true
  end
end
