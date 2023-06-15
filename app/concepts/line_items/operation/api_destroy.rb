module LineItems
  module Operation
    class ApiDestroy

      def initialize(item_id,current_cart)
        @item_id = item_id
        @current_cart = current_cart
      end  

      def call
        item = Item.find(@item_id)
        line_item = @current_cart.line_items.find_by(item_id: item)
        if line_item
          line_item.destroy
        else
          raise 'Element not found in cart'
        end
      end
  
    end
  end
end
