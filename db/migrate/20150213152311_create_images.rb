class CreateImages < ActiveRecord::Migration[4.2]
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.string :image

      t.timestamps null: false
    end
  end
end
