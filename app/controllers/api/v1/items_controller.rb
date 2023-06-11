module Api
  module V1
    class ItemsController < ApiController

      # GET /items
      def index
        @items = Items::Query::Index.new(filter_params).call
        render json: { data: @items }, status: :ok 
      end

      # GET /items/:id
      def show
        @item = Item.find(params[:id])
        render json: { data: @item }, status: :ok 
      end

      private
      
      def filter_params
        params.slice(:search, :sort, :direction, :tags)
      end
    
    end
  end
end
