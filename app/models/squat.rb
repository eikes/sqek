class Squat < ActiveRecord::Base

  extend FriendlyId

  belongs_to :city

  has_many :periods

  validates :name, presence: true

  validates :slug, presence: true, uniqueness: true

  validates_associated :periods

  # todo: validations
  # no overlapping periods
  # no two open ended periods

  accepts_nested_attributes_for :periods, allow_destroy: true
  
  friendly_id :name, use: :slugged

  def latlng
    lat && lng ? [lat, lng] : nil
  end

end
