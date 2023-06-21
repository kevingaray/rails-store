module Users
  module Query
    class Show

      def initialize(user_id,current_user)
        @user_id = user_id
        @current_user = current_user
      end

      def call
        user = User.find(@user_id)
        raise "Unable to find user with 'id': #{user.id}" if user.deleted_at && !@current_user.admin
        user
      end

    end
  end
end
