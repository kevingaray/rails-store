require "test_helper"

class ItemTest < ActiveSupport::TestCase

  test "item should not be valid without a name" do
    item = build(:item) 
    item.name = ""
    assert_not item.valid?
  end

  test 'item cant have a negative price' do
    item = build(:item) 
    item.price = - item.price
    assert_not item.valid?
  end

  test 'item cant have a negative stock' do
    item = build(:item) 
    item.stock = - item.stock
    assert_not item.valid?
  end

end
