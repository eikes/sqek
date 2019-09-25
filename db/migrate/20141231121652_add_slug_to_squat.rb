class AddSlugToSquat < ActiveRecord::Migration[4.2]
  def change
    add_column :squats, :slug, :string
    add_index :squats, :slug, unique: true
  end
end
