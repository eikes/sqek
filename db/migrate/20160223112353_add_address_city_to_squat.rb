class AddAddressCityToSquat < ActiveRecord::Migration[4.2]
  def up
    add_column :squats, :address_city, :string
    City.all.each do |city|
      city.squats.update_all(address_city: city.name)
    end
  end
  def down
    remove_column :squats, :address_city, :string
  end
end
