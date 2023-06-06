require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  test 'each comment should have an user asociate' do
    comment = create(:comment) 
    comment.user = nil
    assert_not comment.valid?
  end

  test 'each comment should have a commentable type associate' do
    comment = create(:comment)
    comment.commentable_type=nil
    assert_not comment.valid?
  end

  test 'each comment should have a commetable id asociate' do
    comment = create(:comment)
    comment.commentable_id=nil
    assert_not comment.valid?
  end

end
