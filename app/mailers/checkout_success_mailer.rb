class CheckoutSuccessMailer < ApplicationMailer
  def checkout_success_email(order)
    @order = order
    @user = order.user

    mail(to: @user.email, subject: 'SnackStore: payment success')
  end
end
