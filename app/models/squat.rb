class Squat < ActiveRecord::Base

  extend FriendlyId

  belongs_to :city

  validates :slug, presence: true, uniqueness: true
  
  friendly_id :name, use: :slugged

  def latlng
    lat && lng ? [lat, lng] : nil
  end

end
