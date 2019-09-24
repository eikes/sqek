class City < ApplicationRecord

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

  enum label_position: { bottom: 0, right: 1, top: 2 }

  def latlng
    lat && lng ? [lat, lng] : nil
  end

  def squat_bounds
    if squats.empty?
      nil
    else
      [
        [ squats.published.minimum(:lat),
          squats.published.minimum(:lng)],
        [ squats.published.maximum(:lat),
          squats.published.maximum(:lng)]
      ]
    end
  end

  def menu_name
    if external_url.blank?
      "#{name} (#{squats.published.count})"
    else
      name
    end
  end
end
