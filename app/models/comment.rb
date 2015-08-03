class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates :title, :body, :email, :commentable, presence: true
end
