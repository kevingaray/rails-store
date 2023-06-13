module Api
  module V1
    class UsersController < ApiController
      before_action :verify_is_admin, only: %i[create destroy]

      #GET /users
      def index
        @users = User.all
        render json: { data: Users::Representer::UserRepresenter.for_collection.new(@users) }, status: :ok
      end

      #GET /users/:id
      def show
        begin
          @user = User.find(params[:id])
          render json: { data: Users::Representer::UserRepresenter.new(@user) }, status: :ok
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      #POST /users
      def create
        @user = User.new(user_params)
        if @user.save
          render json: { data: Users::Representer::UserRepresenter.new(@user) }, status: :created
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
