class Picture < ApplicationRecord
  default_scope{ order('created_at DESC')}
  mount_uploader :picture, PictureUploader

  has_and_belongs_to_many :squats, uniq: true
  has_many :cities, through: :squats

  validates :title, :picture, :squats, presence: true

end
