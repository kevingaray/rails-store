module LineItems
  module Operation
    class QuantityUp
      
      def initialize(item_id)
        @item_id = item_id
      end

      def call
        line_item = LineItem.find(@item_id)
        if line_item.item.stock > line_item.quantity
          line_item.quantity += 1
          line_item.save
        else
          raise 'Not Enough Stock'
        end
      end
      
    end
  end
end
