Stripe.api_key = ENV['STRIPE_SECRET_KEY']

unless Stripe::Plan.retrieve(Subscription::PLAN)
  Stripe::Plan.create(
    amount: 900,
    interval: 'monthly',
    name: '100 Monthly',
    currency: 'usd',
    id: Subscription::PLAN
  )
end
