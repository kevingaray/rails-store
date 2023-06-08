module LineItems
  module Operation
    class QuantityDown
      
      def initialize(item_id)
        @item_id = item_id
      end

      def call
        line_item = LineItem.find(@item_id)
        if line_item.quantity > 1
          line_item.quantity -= 1
          line_item.save
        else
          raise 'Need at least one item'
        end
      end
      
    end
  end
end