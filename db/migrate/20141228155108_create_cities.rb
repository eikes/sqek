class CreateCities < ActiveRecord::Migration[4.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.text :body
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
