json.array!([@city]) do |city|
  json.extract! city, :id, :name, :body, :latlng
  json.url city_squats_url(city)
end

