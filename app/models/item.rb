class Item < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :items_change_logs
  validates :name, presence: true,  length: {minimum: 6, maximum: 100}

  def self.search(search)
    if search
      @items = Item.where("LOWER(name) LIKE LOWER(?)", "%"+search+"%")
    else
      @items = Item.all
    end
  end

end
