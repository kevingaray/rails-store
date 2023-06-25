class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']

    event = nil

    begin
        event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { message: 'Invalid payload' }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { message: 'Invalid signature' }, status: :bad_request
      return
    end

    case event.type
    when 'checkout.session.completed'
      checkout_data = event.data.object
      Orders::Operation::Checkout.new(data: checkout_data).call
    else
        puts "Unhandled event type: #{event.type}"
    end

    render json: { message: 'success' }, status: :ok

  end
end
