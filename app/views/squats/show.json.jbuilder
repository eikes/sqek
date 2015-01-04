json.array!([@squat]) do |squat|
  json.extract! squat, :id, :name, :body, :latlng
  json.popup squat.name
end
