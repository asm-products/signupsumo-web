Stripe.api_key = ENV['STRIPE_SECRET_KEY']

unless Stripe::Plan.retrieve('100_monthly')
  Stripe::Plan.create(
    amount: 900,
    interval: 'monthly',
    name: '100 Monthly',
    currency: 'usd',
    id: '100_monthly'
  )
end
