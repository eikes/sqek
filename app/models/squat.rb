class Squat < ActiveRecord::Base

  belongs_to :city

  def latlng
    lat && lng ? [lat, lng] : nil
  end

end
