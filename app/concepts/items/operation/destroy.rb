module Items
  module Operation
    class Destroy < ApplicationService

      def initialize(id)
        @id = id
      end

      def call
        item = Item.find(@id)
        item.destroy
      end

    end
  end
end
