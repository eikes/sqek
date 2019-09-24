class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  validates :title, :email, :body, :commentable, presence: true

  def city
    if commentable.class == City
      commentable
    else
      commentable.city
    end
  end
end
