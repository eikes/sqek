module CommentsHelper

  def commentable_path(commentable)
    if commentable.class == City
      city_path commentable
    elsif commentable.class == Squat
      city_squat_path commentable.city, commentable
    end
  end

end
