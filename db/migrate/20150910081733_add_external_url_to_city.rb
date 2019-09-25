class AddExternalUrlToCity < ActiveRecord::Migration[4.2]
  def change
    add_column :cities, :external_url, :string, default: 0
  end
end
