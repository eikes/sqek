class AddAddressToSquat < ActiveRecord::Migration
  def change
    add_column :squats, :address, :string
  end
end
