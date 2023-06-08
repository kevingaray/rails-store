class LineItemsController < ApplicationController

  def create
    LineItems::Operation::Create.new(params[:item_id], current_cart).call
    redirect_to cart_path(current_cart)
  end

  def destroy
    LineItem.find(params[:id]).destroy
    redirect_to cart_path(@current_cart)
  end 
  
  def add_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.item.stock > @line_item.quantity
      @line_item.quantity += 1
      @line_item.save
    else
      flash[:alert] = "Not enough stock"
    end
    redirect_to cart_path(@current_cart)
  end
  
  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
      @line_item.save
    else
      flash[:alert] = "Need at least one item"
    end
    redirect_to cart_path(@current_cart)
  end
  
end
