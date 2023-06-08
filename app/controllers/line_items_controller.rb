class LineItemsController < ApplicationController

  def create
    LineItems::Operation::Create.new(params[:item_id], current_cart).call
    redirect_to cart_path(current_cart)
  end

  def destroy
    LineItem.find(params[:id]).destroy
    redirect_to cart_path(current_cart)
  end 
  
  def add_quantity
    begin
      LineItems::Operation::QuantityUp.new(params[:id]).call
    rescue => e
      flash[:alert] = e.message
    ensure
      redirect_to cart_path(current_cart)
    end
  end
  
  def reduce_quantity
    begin
      LineItems::Operation::QuantityDown.new(params[:id]).call
    rescue => e
      flash[:alert] = e.message
    ensure
      redirect_to cart_path(current_cart)
    end
  end
  
end
