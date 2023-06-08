module LineItems
  module Operation
    class Create
      
      def initialize(item_id,current_cart)
        @item_id = item_id
        @current_cart = current_cart
      end

      def call
        chosen_item = Item.find(@item_id)
        if @current_cart.items.include?(chosen_item)
          line_item = @current_cart.line_items.find_by(item_id: chosen_item.id)
          line_item.quantity += 1
        else
          line_item = LineItem.new
          line_item.cart = @current_cart
          line_item.item = chosen_item
        end
        line_item.save
      end

    end
  end
end
