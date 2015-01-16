class City < ActiveRecord::Base
  
  extend FriendlyId

  has_many :squats

  validates :slug, presence: true, uniqueness: true
  
  friendly_id :name, use: :slugged

  has_paper_trail

  scope :by_name, -> { order(:name) }

  def latlng
    lat && lng ? [lat, lng] : nil
  end
end
