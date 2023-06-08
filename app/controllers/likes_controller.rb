class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like

  def create
    begin
      Likes::Operation::Create.new(@liked,@item,current_user).call
    rescue => e
      flash[:alert] = e.message
    ensure
      redirect_to item_path(@item)
    end
  end

  def destroy
    begin
      Likes::Operation::Destroy.new(@liked).call
    rescue => e
      flash[:alert] = e.message
    ensure
      redirect_to item_path(@item)
    end
  end

  private
  def find_like
    @item = Item.find(params[:item_id])
    @liked = Like.find_by(user_id: current_user.id, item_id: @item.id)
  end

end
