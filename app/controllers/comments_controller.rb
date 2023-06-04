class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = @commentable.comments.new(comment_params)
    comment.user = current_user
    rate = comment.rate
    comment.rate = 3 if rate.nil? || rate < 1 || rate > 5
    comment.save
    flash[:notice] = "Your comment was successfully posted."
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :rate, :approved)
  end
end
