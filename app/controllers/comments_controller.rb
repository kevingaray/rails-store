class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    Comments::Operation::Create.new(@commentable,comment_params,current_user).call
    flash[:notice] = "Your comment was successfully posted."
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :rate, :approved)
  end

end
