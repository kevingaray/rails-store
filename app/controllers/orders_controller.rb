class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    current_user.support ? Order.all.order(id: :desc) : @current_user.orders.order(id: :desc)
  end

  def show
    @order = Order.find(params[:id])
    unless @current_user.support || @current_user.id == @order.user_id
      flash[:alert] = "User not allowed"
      redirect_to orders_path
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to root_path
  end

  private
  def order_params
    params.require(:order).permit(:user_id)
  end
  
end
