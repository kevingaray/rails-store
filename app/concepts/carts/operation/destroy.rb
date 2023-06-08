module Carts
  module Operation
    class Destroy

      def initialize(session)
        @session = session
      end

      def call
        Cart.destroy(@session[:cart_id])
        @session[:cart_id] = nil
      end

    end
  end
end
