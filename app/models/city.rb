class City < ActiveRecord::Base

  extend FriendlyId

  has_and_belongs_to_many :users
  has_many :squats
  has_many :pictures, through: :squats
  has_many :comments, as: :commentable

  validates :slug,
            presence: true,
            uniqueness: true

  validates :lat,
            :lng,
            presence: true

  friendly_id :name, use: :slugged

  has_paper_trail

  scope :by_name, -> { order(:name) }

  def latlng
    lat && lng ? [lat, lng] : nil
  end

  def squat_bounds
    if squats.empty?
      nil
    else
      [
        [ squats.minimum(:lat),
          squats.minimum(:lng)],
        [ squats.maximum(:lat),
          squats.maximum(:lng)]
      ]
    end
  end

  def menu_name
    if external_url.blank?
      "#{name} (#{squats.count})"
    else
      name
    end
  end
end
