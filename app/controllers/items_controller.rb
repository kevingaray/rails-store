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
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item created succesfully"
      redirect_to @item
    else
      flash[:alert] = 'There was something wrong the item info'
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Item updated succesfully"
      redirect_to @item
    else
      flash[:alert] = 'There was something wrong the item info'
      render 'edit'
    end
  end

  
  private

  def item_params
    params.require(:item).permit(:name, :price, :stock)
  end



  
end
  