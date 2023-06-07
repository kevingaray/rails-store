class ItemsController < ApplicationController
  before_action :verify_is_support, only: %i[edit update]
  before_action :verify_is_admin, only: %i[new create destroy]

  def index
    @items = Items::Query::Index.new(filter_params).call
  end

  def show
    @item = Item.find(params[:id])
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
      flash[:alert] = e.record.errors.full_messages#.join(', ')
      redirect_to new_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    create_or_delete_items_tags(@item, tags_params)
    if @item.update(item_params)
      save_changes_in_log(@item)
      flash[:notice] = "Item updated succesfully"
      redirect_to @item
    else
      flash[:alert] = 'There was something wrong the item info'
      render 'edit'
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :price, :stock)
  end

  def save_changes_in_log(item)
    changes = @item.saved_changes
    changes.each do |k, v|
      log_entry = ItemsChangeLog.new(item_id: item.id, user_id: current_user.id)
      log_entry.column_name = k
      log_entry.prev_value = v[0].to_s
      log_entry.new_value = v[1].to_s
      log_entry.save!
    end
  end

  def filter_params
    params.slice(:search, :sort, :direction, :tags)
  end

  def tags_params
    params[:item][:tags]
  end

end
  