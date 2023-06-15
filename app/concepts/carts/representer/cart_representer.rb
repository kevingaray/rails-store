require 'representable/json'
module Carts
  module Representer
    class CartRepresenter < Representable::Decorator
      include Representable::JSON

      collection :line_items, as: :items do
        property :item_id
        property :name, getter: ->(represented:, **) { represented.item.name }
        property :unit_price, getter: ->(represented:, **) { represented.item.price }
        property :quantity
        property :total, getter: ->(represented:, **) { represented.item.price*quantity }
      end
    end
  end
end
