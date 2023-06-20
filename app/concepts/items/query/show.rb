module Items
  module Query
    class Show

      def initialize(item_id,current_user)
        @item_id = item_id
        @current_user = current_user
      end

      def call
        item = Item.find(@item_id)
        raise "Unable to find item with 'id': #{item.id}" if item.deleted_at && !@current_user.admin
        item
      end

    end
  end
end
