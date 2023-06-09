class LineItemDecorator < BaseDecorator
  decorates :line_item

  def total_price
    quantity * item.price
  end
  
end
