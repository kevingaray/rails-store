class Items::CommentsController < CommentsController
  before_action :set_commentable
  before_action :find_comment, only: %i[delete approved]
  before_action :verify_is_support, only: %i[delete approved]

  def delete
    @comment.destroy
    redirect_to item_path(@commentable)
  end

  def approved
    @comment.approved = true
    @comment.save
    redirect_to item_path(@commentable)
  end

  private

  def set_commentable
    @commentable = Item.find(params[:item_id])
  end

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end
  
end