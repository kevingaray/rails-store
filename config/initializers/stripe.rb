Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_API_KEY_PUBLISHABLE'],
  :secret_key      => ENV['STRIPE_API_KEY_SECRET']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]