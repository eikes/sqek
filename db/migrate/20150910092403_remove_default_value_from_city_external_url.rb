class RemoveDefaultValueFromCityExternalUrl < ActiveRecord::Migration
  def up
    change_column_default(:cities, :external_url, nil)
  end
  def down
    change_column_default(:cities, :external_url, 0)
  end
end
