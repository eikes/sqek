class AddExternalUrlToCity < ActiveRecord::Migration
  def change
    add_column :cities, :external_url, :string, default: 0
  end
end
