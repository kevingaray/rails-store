module Orders
  module Operation
    class Create

      def initialize(user,current_cart)
        @user = user
        @current_cart = current_cart
      end

      def call
        order = Order.new(user_id: @user.id)
        @current_cart.line_items.each do |li|
          reduce_stock(li)
          order.line_items << li
          li.cart_id = nil
        end
        order.save
        CheckoutSuccessMailer.checkout_success_email(order).deliver_later
        order
      end

      def reduce_stock(line_item)
        item = Item.find(line_item.item_id)
        item.stock -= line_item.quantity
        if item.likes.size.positive? && (item.stock <= 3 && item.stock.positive?)
          StockNotifyMailer.notify_email(item.id).deliver_later
        end
        item.save
      end

    end
  end
end