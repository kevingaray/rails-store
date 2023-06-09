class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
end
