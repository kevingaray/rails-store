module Api
  module V1
    class LikesController < ApiController

      # POST /items/:id/likes
      def create
        begin
          find_like
          Likes::Operation::Create.new(@liked,@item,@current_user).call
          render json: { item: @item, likes: @item.likes.count }, status: :ok
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      # DELETE /items/:id/likes
      def destroy
        begin
          find_like
          Likes::Operation::Destroy.new(@liked).call
          render json: { item: @item, likes: @item.likes.count }, status: :ok
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      private
      def find_like
        @item = Item.find(params[:item_id])
        @liked = Like.find_by(user_id: @current_user.id, item_id: @item.id)
      end

    end
  end
end
