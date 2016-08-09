class CommentUpdateForm < Reform::Form
  property :title
  property :body
  property :email

  validates :title,
            :body,
            :email,
            presence: true
end
