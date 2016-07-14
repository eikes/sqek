json.array!(@squats) do |squat|
  json.extract! squat, :name, :slug, :latlng, :tags
  json.periods squat.periods, :start_year, :end_year
  json.popup render( { partial: "squats/popup", formats: [:html], locals: { squat: squat } } )
  json.icon squat_get_icon(squat)
end
