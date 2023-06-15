module Api
  module V1
    class LineItemsController < ApiController

      # POST /line_items
      def create
        begin
          LineItems::Operation::ApiCreate.new(line_item_params, current_cart).call
          render json: { data: Carts::Representer::CartRepresenter.new(current_cart) }, status: :created
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      # DELETE /line_items
      def destroy
        begin
          LineItems::Operation::ApiDestroy.new(params[:item_id],current_cart).call
          head :no_content
        rescue => e
          render json: { errors: e }, status: :not_found
        end

      end

      private

      def line_item_params
        params.require(:line_item).permit(:item_id, :quantity)
      end

    end
  end
end
