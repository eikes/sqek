# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview
  def comment_notification
    NotificationsMailer.comment_notification(['someone@example.com'], Comment.first)
  end
  def squat_notification
    NotificationsMailer.squat_notification(['someone@example.com'], Squat.first)
  end
end
