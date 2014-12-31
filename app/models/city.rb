class City < ActiveRecord::Base
  
  extend FriendlyId

  has_many :squats

  validates :slug, presence: true, uniqueness: true
  
  friendly_id :name, use: :slugged

  def latlng
    lat && lng ? [lat, lng] : nil
  end
end
