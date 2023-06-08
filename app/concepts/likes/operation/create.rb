module Likes
  module Operation
    class Create

      def initialize(liked,item,user)
        @liked = liked
        @item = item
        @user = user
      end

      def call
        unless @liked
          @item.likes.create(user_id: @user.id)
        else
          raise "You can't like more than once"
        end
      end

    end
  end
end