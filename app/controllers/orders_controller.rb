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
    Orders::Operation::Create.new(current_user,current_cart).call
    Carts::Operation::Destroy.new(session).call
    redirect_to root_path
  end

end
