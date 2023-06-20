module Items
  module Operation
    class Destroy < ApplicationService

      def initialize(id)
        @id = id
      end

      def call
        item = Item.find(@id)
        item.update_attribute(:deleted_at, Time.current)
      end

    end
  end
end
