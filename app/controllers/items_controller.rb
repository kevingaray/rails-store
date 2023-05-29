class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params.require(:item).permit(:name, :price, :stock))
    if @item.save
      flash[:notice] = "Item created succesfully"
      redirect_to @item
    else
      flash[:alert] = 'There was something wrong the item info'
      render 'new'
    end
  end


  
end
  