json.array!(@squats) do |squat|
  json.extract! squat, :name, :body, :latlng
  json.periods squat.periods, :start_year, :end_year
  json.url city_squat_url(@city, squat)
end
