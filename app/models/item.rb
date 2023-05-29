class Item < ApplicationRecord
  has_many :likes, dependent: :destroy
  validates :name, presence: true,  length: {minimum: 6, maximum: 100}

end
