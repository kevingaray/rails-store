module Api
  module V1
    class CommentsController < ApiController
      before_action :verify_is_admin, only: %i[destroy approve]
      before_action :set_commentable, only: %i[create]

      # POST users/{id}/comments
      def create
        Comments::Operation::Create.new(@commentable, comment_params, @current_user).call
        head :no_content
      end

      # only to Admin: approve or delete
      # DELETE users/{id}/comments/{comment_id}
      def destroy
        begin
          Comments::Operation::Destroy.new(params[:comment_id],params[:user_id]).call
          head :no_content
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      # Post users/{id}/comments/{comment_id}
      def approve
        begin
          Comments::Operation::Approve.new(params[:comment_id],params[:user_id]).call
          head :no_content
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      private
      def comment_params
        params.require(:comment).permit(:body, :rate)
      end

      def set_commentable
        @commentable = User.find(params[:user_id])
      end
    end
  end
end
