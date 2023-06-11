class Item < ApplicationRecord
  validates :name, presence: true,  length: {minimum: 3, maximum: 100}
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  has_many :likes, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :items_change_logs
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :comments, as: :commentable

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [220, 220]
  end

end
