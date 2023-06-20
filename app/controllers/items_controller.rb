class ItemsController < ApplicationController
  before_action :verify_is_support, only: %i[edit update]
  before_action :verify_is_admin, only: %i[new create destroy]

  def index
    @pagy, @items = pagy(Items::Query::Index.new(filter_params).call)
  end

  def show
    begin
      @item = Items::Query::Show.new(params[:id],current_user).call
    rescue => e
      flash[:alert] = e.message
      redirect_to items_path
    end
  end

  def new
    @item = Item.new
  end

  def create
    begin
      @item = Items::Operation::Create.call(item_params,tags_params)
      flash[:notice] = "Item created successfully"
      redirect_to @item
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.record.errors.full_messages
      redirect_to new_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    begin
      Items::Operation::Update.call(@item,item_params,tags_params,current_user)
      flash[:notice] = "Item updated succesfully"
      redirect_to @item
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.record.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    Items::Operation::Destroy.call(params[:id])
    redirect_to items_path
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :price, :stock, :image)
  end

  def filter_params
    params.slice(:search, :sort, :direction, :tags)
  end

  def tags_params
    params[:item][:tags]
  end

end
  