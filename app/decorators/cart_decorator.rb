class CartDecorator < BaseDecorator
  decorates :cart

  def sub_total
    sum = 0
    line_items.each do |line_item|
      sum += line_item.quantity * line_item.item.price
    end
    ActionController::Base.helpers.number_to_currency(sum)
  end
  
end
