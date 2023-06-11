module Api
  module V1
    class AuthenticationController < ApiController

      skip_before_action :authenticate_request

      # #POST auth/login
      def login
        @user = User.find_by_email(params[:email])
        if @user&.valid_password?(params[:password])
          token = jwt_encode(user_id: @user.id)
          render json: { token: token , admin: @user.admin , support: @user.support}, status: :ok
        else
          render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
      end

    end
  end
end
