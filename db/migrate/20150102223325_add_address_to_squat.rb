class AddAddressToSquat < ActiveRecord::Migration[4.2]
  def change
    add_column :squats, :address, :string
  end
end
