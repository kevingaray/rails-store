class CheckoutController < ApplicationController

  def create
    @stripe_session = Stripe::Checkout::Session.create(
      {
        customer: current_user.stripe_customer_id,
        payment_method_types: ['card'],
        mode: 'payment',
        line_items: @current_cart.line_items.collect do |li|
                      li.to_builder.attributes!
                    end,
        success_url:,
        cancel_url:
      }
    )
  end

  def success
    Carts::Operation::Destroy.new(session).call
  end

  def cancel
    # Orders::Operation::Reject.call(current_user:, current_cart: @current_cart)
  end
end
