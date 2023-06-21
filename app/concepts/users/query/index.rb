module Users
  module Query
    class Index

      def initialize(current_user)
        @current_user = current_user
      end

      def call
        @current_user.admin ? User.all : User.all.where(deleted_at: nil)
      end

    end
  end
end
