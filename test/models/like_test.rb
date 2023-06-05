require "test_helper"

class LikeTest < ActiveSupport::TestCase
  
  test 'like should have an user asociate' do
    like = Like.new
    like.item_id = rand(1..10)
    assert_not like.valid?
  end

  test 'like should have an item asociate' do
    like = Like.new
    like.user_id = rand(1..10)
    assert_not like.valid?
  end

end
