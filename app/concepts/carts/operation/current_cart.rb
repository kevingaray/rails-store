module Carts
  module Operation
    class CurrentCart

      def initialize(session)
        @session = session
      end

      def call
        return find_existing_cart if @session[:cart_id]
      
        create_new_cart
      end

      private

      def find_existing_cart
        cart = Cart.find_by(id: @session[:cart_id])
        return cart if cart

        @session[:cart_id] = nil
      end

      def create_new_cart
        cart = Cart.create
        @session[:cart_id] = cart.id
        cart
      end

    end
  end
end
