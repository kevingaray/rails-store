module LineItems
  module Operation
    class ApiCreate

      def initialize(line_item_params,current_cart)
        @item_id = line_item_params['item_id']
        @quantity = line_item_params['quantity'].to_i
        @current_cart = current_cart
      end

      def call
        item = Item.find(@item_id)
        raise "Unable to find item with 'id': #{item.id}" if item.deleted_at
        raise 'Not enough Stock' if @quantity > item.stock
        create_or_find_item_in_cart(@current_cart,item,@quantity)
      end
      
      private

      def create_or_find_item_in_cart(current_cart, chosen_item, quantity)
        if current_cart.items.include?(chosen_item)
          line_item = current_cart.line_items.find_by(item_id: chosen_item)
        else
          line_item = LineItem.new
          line_item.cart = current_cart
          line_item.item = chosen_item
        end
        line_item.quantity = quantity
        line_item.save
      end

    end
  end
end
