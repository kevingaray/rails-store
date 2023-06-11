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
        begin
          @item = Item.find(params[:id])
          render json: { data: @item }, status: :ok 
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end
       
      # POST /items
      def create
        begin
          @item = Items::Operation::Create.call(item_params)
          render json: { data: @item }, status: :created
        rescue ActiveRecord::RecordInvalid => e
          render json: { errors: e.record.errors.full_messages}, status: :bad_request
        end
      end

      # DELETE /items/:id
      def destroy
        begin 
          Items::Operation::Destroy.call(params[:id])
          render json: { Success: 'Item deleted'}, status: :accepted
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end
      
      # PUT /items/:id
      def update
        begin
          item = Item.find(params[:id])
          Items::Operation::Update.call(item,item_params,nil, @current_user)
          head :no_content
        rescue => e 
          render json: { errors: e }, status: :not_acceptable
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
