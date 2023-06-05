require 'faker'

class ItemsChangeLogTest < ActiveSupport::TestCase

  test 'each item_change_log should have an user associate' do
    item_change_log = ItemsChangeLog.create
    item_change_log.item_id = rand(1..10)
    assert_not item_change_log.valid?
  end

  test 'each item_change_log should have an item_id associate' do
    item_change_log = ItemsChangeLog.create
    item_change_log.user_id = rand(1..10)
    assert_not item_change_log.valid?
  end

end
