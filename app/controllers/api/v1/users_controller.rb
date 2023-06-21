module Api
  module V1
    class UsersController < ApiController
      before_action :verify_is_admin, only: %i[create destroy]

      #GET /users
      def index
        @users = Users::Query::Index.new(@current_user).call
        render json: { data: Users::Representer::UserRepresenter.for_collection.new(@users) }, status: :ok
      end

      #GET /users/:id
      def show
        begin
          @user = Users::Query::Show.new(params[:id], @current_user).call
          render :show, status: :ok
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      #POST /users
      def create
        begin
          @user =  Users::Operation::Create.new(user_params).call
          render json: { data: Users::Representer::UserRepresenter.new(@user) }, status: :created
        rescue => e
          render json: { errors: e }, status: :unprocessable_entity
        end
      end

      #DELETE /users/:id
      def destroy
        begin 
          Users::Operation::Destroy.new(params[:id]).call
          render json: { Success: 'User deleted'}, status: :accepted
        rescue => e
          render json: { errors: e }, status: :not_found
        end
      end

      private

      def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :support, :password, :password_confirmation)
      end

    end
  end
end
