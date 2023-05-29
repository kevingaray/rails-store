class Item < ApplicationRecord
  has_many :likes, dependent: :destroy

end
