class PaymentMailer < ApplicationMailer
  def failure_notification(user)
    @user = user

    mail(to: @user.email, subject: "#{Time.now.strftime("%B")} payment failed")
  end
end
