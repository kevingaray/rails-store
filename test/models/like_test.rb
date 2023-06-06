require "test_helper"

class LikeTest < ActiveSupport::TestCase
  
  test 'like should have an user asociate' do
    like = create(:like)
    like.user = nil
    assert_not like.valid?
  end

  test 'like should have an item asociate' do
    like = create(:like)
    like.item = nil
    assert_not like.valid?
  end

end
