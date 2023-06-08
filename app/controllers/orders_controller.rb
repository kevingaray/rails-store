class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Orders::Query::Index.new(current_user).call
  end

  def show
    begin
      @order = Orders::Query::Show.new(params[:id], current_user).call  
    rescue => e
      flash[:alert] = e.message
      redirect_to orders_path
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(user_id: current_user.id)
    @current_cart.line_items.each do |li|
      reduce_stock(li)
      @order.line_items << li
      li.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to root_path
  end

  private

  def reduce_stock(line_item)
    item = Item.find(line_item.item_id)
    item.stock -= line_item.quantity
    item.save
  end
  
end
