require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'each comment should have an user asociate' do
    comment = Comment.new
    comment.commentable_type = 'Item'
    comment.commentable_id = rand(1..10)
    assert_not comment.valid?
  end

  test 'each comment should have a commetable type asociate' do
    comment = Comment.new
    comment.user_id = 4
    comment.commentable_id = rand(1..10)
    assert_not comment.valid?
  end

  test 'each comment should have a commetable id asociate' do
    comment = Comment.new
    comment.user_id = rand(1..10)
    comment.commentable_type = 'Item'
    assert_not comment.valid?
  end
end
