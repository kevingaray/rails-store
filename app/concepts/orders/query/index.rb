module Orders
  module Query
    class Index

      def initialize(user)
        @user = user
      end

      def call
        @user.support ? Order.all.order(id: :desc) : @user.orders.order(id: :desc)
      end

    end
  end
end
