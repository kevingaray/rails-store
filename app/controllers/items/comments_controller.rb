class Items::CommentsController < CommentsController
  before_action :set_commentable
  before_action :verify_is_support, only: %i[delete approved]

  def delete
    comment = Comment.find(params[:comment_id])
    comment.destroy
    redirect_to item_path(params[:item_id])
  end

  def approved
    comment = Comment.find(params[:comment_id])
    comment.approved = true
    comment.save
    redirect_to item_path(params[:item_id])
  end

  private

  def set_commentable
    @commentable = Item.find(params[:item_id])
  end
  
end
