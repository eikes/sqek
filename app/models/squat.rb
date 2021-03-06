class Squat < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  attr_accessor :current_user

  TAGS = [
    'uncertain_date',
    'uncertain_location',
    'social_center',
    'self_evicted',
    'occupied_public_space',
    'caravan_site'
  ]

  belongs_to :city
  has_and_belongs_to_many :pictures
  has_many :periods, dependent: :destroy
  has_many :comments, as: :commentable

  serialize :tags, JSON

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  validates :name,
            :lat,
            :lng,
            presence: true

  validates :slug,
            presence: true,
            uniqueness: true

  validates :external_user_email,
            presence: true,
            if: Proc.new { current_user.nil? }

  validates_associated :periods

  # has at least one period
  validate do
    errors.add(:base, I18n.t(:at_least_one_period_error)) if periods.reject(&:marked_for_destruction?).empty?
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

  before_save :clean_tags

  accepts_nested_attributes_for :periods, allow_destroy: true

  has_paper_trail

  def self.form_tags
    TAGS.map { |tag| [I18n.t(tag), tag] }
  end

  def clean_tags
    tags.reject! { |t| t.blank? } if tags.present?
  end

  def latlng
    lat && lng ? [lat, lng] : nil
  end

  def full_address
    [address, address_city].reject(&:blank?).join(", ")
  end

end
