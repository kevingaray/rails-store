class Orders::CommentsController < CommentsController
  before_action :set_commentable

  private
  
  def set_commentable
    @commentable = Order.find(params[:order_id])
  end
end
