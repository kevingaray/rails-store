class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :comments, as: :commentable
  belongs_to :user
end
