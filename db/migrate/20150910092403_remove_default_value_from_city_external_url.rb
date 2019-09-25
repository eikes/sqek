class RemoveDefaultValueFromCityExternalUrl < ActiveRecord::Migration[4.2]
  def up
    change_column_default(:cities, :external_url, nil)
  end
  def down
    change_column_default(:cities, :external_url, 0)
  end
end
