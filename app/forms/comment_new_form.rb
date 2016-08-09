class CommentNewForm < Reform::Form
  property :title
  property :body
  property :email
  property :commentable_id
  property :commentable_type

  validates :title,
            :body,
            :email,
            :commentable_id,
            :commentable_type,
            presence: true

  validates :commentable_id, numericality: { only_integer: true }
  validates :commentable_type, inclusion: ['City', 'Squat']
end
