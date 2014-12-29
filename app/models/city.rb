class City < ActiveRecord::Base
  def latlng
    lat && lng ? [lat, lng] : nil
  end

  def to_param
    id.to_s + "-" + name.parameterize
  end
end
