module Orders
  module Operation
    class Checkout

      def initialize(data)
        @data = data
      end

      def call
        session_id = @data[:data][:id]
        customer = @data[:data][:customer]

        user = User.find_by(stripe_customer_id: customer)
        cart = Cart.create
        session_items = Stripe::Checkout::Session.retrieve({ id: session_id, expand: ['line_items'] })
        session_items.line_items.data.each do |line_item|
          item = Item.find_by(stripe_product_id: line_item.price.product)
          quantity = line_item.quantity
          LineItem.create(item_id: item.id, quantity:, cart_id: cart.id)
        end
        Orders::Operation::Create.new(user,cart).call
      end

    end
  end
end