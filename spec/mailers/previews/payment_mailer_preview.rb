class PaymentMailerPreview < ActionMailer::Preview
  def failure_notification
    PaymentMailer.failure_notification(User.first)
  end
end
