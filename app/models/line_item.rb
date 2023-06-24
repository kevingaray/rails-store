class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  def to_builder
    Jbuilder.new do |line_item|
      line_item.price item.stripe_price_id
      line_item.quantity quantity
    end
  end
  
end
