class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def destroy
    Carts::Operation::Destroy.new(session).call
    redirect_to root_path
  end

end
