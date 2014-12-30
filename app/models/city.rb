class City < ActiveRecord::Base

  has_many :squats

  def latlng
    lat && lng ? [lat, lng] : nil
  end

  def to_param
    id.to_s + "-" + name.parameterize
  end
end
