json.array!(@cities) do |city|
  json.extract! city, :id, :name, :body, :latlng, :label_position
  json.url city_squats_url(city)
end
