class NotificationsMailer < ApplicationMailer

  def comment_notification(recipients, comment)
    @comment = comment
    mail(to: recipients, subject: "[Sqek map] New comment for #{comment.commentable.name}")
  end

  def squat_notification(recipients, squat)
    @squat = squat
    mail(to: recipients, subject: "[Sqek map] Please review new squat: #{squat.name}")
  end

end
