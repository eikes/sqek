class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates :title, :body, :email, :commentable, presence: true

  def city
    if commentable.class == City
      commentable
    else
      commentable.city
    end
  end
end
