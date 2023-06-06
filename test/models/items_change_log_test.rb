require "test_helper"

class ItemsChangeLogTest < ActiveSupport::TestCase

  test 'each item_change_log should have an user associate' do
    item_change_log = create(:items_change_log)
    item_change_log.user = nil
    assert_not item_change_log.valid?
  end

  test 'each item_change_log should have an item_id associate' do
    item_change_log = create(:items_change_log)
    item_change_log.item = nil
    assert_not item_change_log.valid?
  end

end
