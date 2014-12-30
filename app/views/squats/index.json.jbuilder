json.array!(@squats) do |squat|
  json.extract! squat, :id, :name, :body, :latlng
  json.url city_squat_url(@city, squat)
end
