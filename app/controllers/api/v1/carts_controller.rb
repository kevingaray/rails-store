module Api
  module V1
    class CartsController < ApiController
      # GET carts/
      def show
        render json: { data: Carts::Representer::CartRepresenter.new(current_cart) }, status: :ok
      end

      # DELETE carts/
      def destroy
        Carts::Operation::Destroy.call(current_cart:, session:)
        head :no_content
      end
    end
  end
end