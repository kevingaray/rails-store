class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def destroy
    current_cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

end
