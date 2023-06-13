require 'representable/json'
module Items
  module Representer
    class ItemRepresenter < Representable::Decorator
      include Representable::JSON

      property :id
      property :type, getter: ->(represented:, **) { represented.class.name }
      property :name
      property :price
      property :stock
      property :likes, getter: ->(represented:, **) { represented.likes.count }
      property :img_url, getter: lambda { |represented:, **|
                                   if represented.image.attached?
                                    represented.image.service_url
                                   end
                                 }
      property :deleted_at
    end
  end
end
