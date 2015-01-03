class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.references :squat, index: true
      t.integer :start_year
      t.integer :start_month
      t.integer :start_day
      t.integer :end_year
      t.integer :end_month
      t.integer :end_day

      t.timestamps null: false
    end
    add_foreign_key :periods, :squats
  end
end
