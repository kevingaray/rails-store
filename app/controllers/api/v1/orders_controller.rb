module Api
  module V1
    class OrdersController < ApiController
      
      # GET /orders
      def index
        @orders = Orders::Query::Index.new(@current_user).call
        render json: { data: @orders }, status: :ok
      end

      # GET /orders/:id
      def show
        begin
          @order = Orders::Query::Show.new(params[:id], @current_user).call  
          render json: {order_date: @order.created_at, order_items: @order.line_items }, status: :ok
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

    end
  end
end
