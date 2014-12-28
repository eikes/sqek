class CreateCities < ActiveRecord::Migration
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
