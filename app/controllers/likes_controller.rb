class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like

  def create
    unless @liked
      @item.likes.create(user_id: current_user.id)
    else
      flash[:alert] = "You can't like more than once"
    end
    redirect_to item_path(@item)
  end

  def destroy
    if @liked
      @liked.destroy
    else
      flash[:alert] = "Cannot unlike"
    end
    redirect_to item_path(@item)
  end

  private
  def find_like
    @item = Item.find(params[:item_id])
    @liked = Like.find_by(user_id: current_user.id, item_id: @item.id)
  end

end
