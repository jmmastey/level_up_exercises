class FeedbackMailer < ActionMailer::Base
  default from: ENV['MAILER_ADDRESS']

  def feedback_email(feedback, user)
    @feedback = feedback
    @user = user
    mail(to: ENV['ADMIN_EMAIL'], subject: @feedback.subject)
  end
end
