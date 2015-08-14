class CommentMailer < ApplicationMailer
  def user_notification(user, comment)
    @user = user
    @comment = comment
    mail(to: @user.email, subject: "[Sqek map] New comment for #{comment.commentable.name}")
  end
end
