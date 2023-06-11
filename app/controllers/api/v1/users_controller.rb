module Api
  module V1
    class UsersController < ApiController
      # before_action :verify_is_admin, only: %i[create destroy]

      #GET /users
      def index
        @users = User.all
        render json: { data: @users }, status: :ok
      end

      #GET /users/:id
      def show
        @user = User.find(params[:id])
        render json: @user, status: :ok
      end

      #POST /users
      def create
        @user = User.new(user_params)
        if @user.save
          render json: { data: @user }, status: :created
        else
          render json: { data: @user.errors }, status: :unprocessable_entity
        end
      end

      #DELETE /users/:id
      def destroy
        @user = User.find(params[:id])
        @user.destroy
        head :no_content
      end

      private

      def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :support, :password, :password_confirmation)
      end

    end
  end
end
