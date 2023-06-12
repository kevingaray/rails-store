module Api
  module V1
    class ApiController < ActionController::API
      include Pagy::Backend
      include JsonWebToken
      before_action :authenticate_request


      private

      def verify_is_admin
        render json: { error: 'Not admin' }, status: :unauthorized unless current_user&.admin
      end

      def verify_is_support
        render json: { error: 'Not support' }, status: :unauthorized unless current_user&.support
      end

      def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        decoded = jwt_decode(header)
        if decoded == "Token not found"
            render json: { error: 'Not authenticated' }, status: :unauthorized
        else
            @current_user = User.find(decoded[:user_id])
        end
      end

      def current_cart
        @current_cart ||= Carts::Operation::CurrentCart.new(session).call
      end

    end
  end
end
