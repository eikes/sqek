class Picture < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  has_and_belongs_to_many :squats
  has_many :cities, through: :squats

  validates :title, :description, :picture, presence: true

end
