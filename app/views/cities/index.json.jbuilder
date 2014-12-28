json.array!(@cities) do |city|
  json.extract! city, :id, :name, :body, :lat, :lng
  json.url city_url(city, format: :json)
end
