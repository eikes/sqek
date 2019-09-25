class CreateCitiesUsersTable < ActiveRecord::Migration[4.2]
  def change
    create_join_table :cities, :users
  end
end
