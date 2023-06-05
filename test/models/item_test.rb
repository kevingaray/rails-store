require "test_helper"
require 'faker'

class ItemTest < ActiveSupport::TestCase
  test "item should not be valid without a name" do
    item = Item.create(
      price: rand(10.00..50.00),
      stock: rand(20..50)
    )
    assert_not item.valid?
  end

end
