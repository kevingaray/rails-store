class Like < ApplicationRecord
  belongs_to :item
  belongs_to :user

  scope :already_like, ->(user_id, item_id) { where('user_id = ? and item_id = ?', user_id, item_id) }
end
