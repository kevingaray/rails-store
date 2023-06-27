# Preview all emails at http://localhost:3000/rails/mailers/
class CheckoutSuccessPreview < ActionMailer::Preview
  def preview_checkout
    order = Order.last
    CheckoutSuccessMailer.checkout_success_email(order)
  end
end
