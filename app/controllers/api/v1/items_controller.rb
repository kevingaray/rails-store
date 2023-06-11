module Api
  module V1
    class ItemsController < ApiController
      skip_before_action :authenticate_request, only: %i[index show]
      
      # GET /items
      def index
        @pagy, @items = pagy(Items::Query::Index.new(filter_params).call)
        render json: { data: @items }, status: :ok 
      end

      # GET /items/:id
      def show
        @item = Item.find(params[:id])
        render json: { data: @item }, status: :ok 
      end

      #POST /items
      def create
        begin
          @item = Items::Operation::Create.call(item_params)
          render json: { data: @item }, status: :created
        rescue ActiveRecord::RecordInvalid => e
          render json: { data: e.record.errors.full_messages}
        end
      end
      
      private

      def item_params
        params.require(:item).permit(:name, :price, :stock, :image)
      end
      
      def filter_params
        params.slice(:search, :sort, :direction, :tags)
      end
    
    end
  end
end
