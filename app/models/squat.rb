class Squat < ActiveRecord::Base

  extend FriendlyId

  belongs_to :city

  has_many :periods, dependent: :destroy

  validates :name,
            :lat,
            :lng,
            presence: true

  validates :slug,
            presence: true,
            uniqueness: true

  validates_associated :periods

  # has at least one period
  validate do
    errors.add(:base, I18n.t(:at_least_one_period_error)) if periods.empty?
  end

  # has location
  validate do
    errors.add(:base, I18n.t(:location_required)) if lat.nil? or lng.nil?
  end

  # no overlapping periods
  validate do
    periods.each do |p1|
      periods.reject{ |p| p == p1 }.each do |p2|
        if p2.start_year > p1.start_year && p1.end_year.present? && p2.start_year < p1.end_year
          errors.add(:base, I18n.t(:overlapping_periods_error))
        end
      end
    end
  end

  # no two open ended periods
  validate do
    if periods.select{ |p| p.end_year.blank? }.size > 1
      errors.add(:base, I18n.t(:two_open_ended_periods_error))
    end
  end

  validate do
    if !link.blank? and not %w( http https ).include?(URI.parse(link).scheme)
      errors.add(:link, I18n.t(:invalid_link_url))
    end
  end

  accepts_nested_attributes_for :periods, allow_destroy: true
  
  friendly_id :name, use: [:slugged, :finders]

  has_paper_trail

  def latlng
    lat && lng ? [lat, lng] : nil
  end

end
