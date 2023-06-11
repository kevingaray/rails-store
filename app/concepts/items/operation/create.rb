module Items
  module Operation
    class Create < ApplicationService

      def initialize(item_params,tags_params = nil)
        @item_params = item_params
        @tags_params = tags_params
      end

      def call
        @item = Item.new(@item_params)
        if @item.save
          create_or_delete_items_tags(@item, @tags_params) if @tags_params
          @item
        else
          raise ActiveRecord::RecordInvalid.new(@item)
        end
      end

    end
  end
end
