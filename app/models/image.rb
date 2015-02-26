class Image < ActiveRecord::Base
  attr_accessible :title, :description, :image
  mount_uploader :picture, PictureUploader

  has_and_belongs_to_many :squats

end
