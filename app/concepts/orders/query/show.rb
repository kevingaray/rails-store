module Orders
  module Query
    class Show

      def initialize(id,user)
        @id = id
        @user = user
      end

      def call
        @order = Order.find(@id)
        unless @user.support || @user.id == @order.user_id
          raise 'User not allowed'
        end
        @order
      end

    end
  end
end
