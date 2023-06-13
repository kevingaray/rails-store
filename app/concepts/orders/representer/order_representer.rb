require 'representable/json'
module Orders
  module Representer
    class OrderRepresenter < Representable::Decorator
      include Representable::JSON

      property :id
      property :type, getter: ->(represented:, **) { represented.class.name }
      property :user, getter: ->(represented:, **) { represented.user.email }
      property :date, getter: ->(represented:, **) { represented.created_at }
      property :accepted
      property :total, getter: lambda { |represented:, **|
                                 represented.line_items.reduce(0) do |sum, e|
                                   sum + (e.quantity * e.item.price)
                                 end
                               }
      collection :line_items, as: :items do
        property :name, getter: ->(represented:, **) { represented.item.name }
        property :unit_price, getter: ->(represented:, **) { represented.item.price }
        property :quantity
      end
    end
  end
end
