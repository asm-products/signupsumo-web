class NotifyPaymentFailure < ActiveJob::Base

  def perform(subscription)
    PaymentMailer.failure_notification(subscription.user).deliver_now
  end
end
