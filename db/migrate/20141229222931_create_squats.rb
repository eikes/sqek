class CreateSquats < ActiveRecord::Migration[4.2]
  def change
    create_table :squats do |t|
      t.string :name
      t.text :body
      t.float :lat
      t.float :lng
      t.float :lng
      t.belongs_to :city, index: true

      t.timestamps null: false
    end
  end
end
