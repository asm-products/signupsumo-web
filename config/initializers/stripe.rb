Stripe.api_key = ENV['STRIPE_SECRET_KEY']

begin
  Stripe::Plan.retrieve(Subscription::PLAN)
rescue Stripe::InvalidRequestError
  Stripe::Plan.create(
    amount: 900,
    interval: 'month',
    name: '100 Monthly',
    currency: 'usd',
    id: Subscription::PLAN
  )
end
