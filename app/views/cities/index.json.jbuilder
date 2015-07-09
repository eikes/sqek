json.array!(@cities) do |city|
  json.extract! city, :id, :name, :body, :latlng, :external_url
  json.url city_squats_url(city)
end
