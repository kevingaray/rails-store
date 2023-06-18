require 'test_helper'

class StockNotifyMailerTest < ActionMailer::TestCase
  test 'create email' do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    liked = Like.find_by(user_id: user.id, item_id: item.id)
    LikeUpdateJob.perform_now(liked,item,user)
    email = StockNotifyMailer.notify_email(item.id)

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal [ENV['DEFAULT_EMAIL']], email.from
    assert_equal [user.email], email.to
    assert_equal "Hurry up, last items in stock of #{item.name}", email.subject
    assert_match "You liked #{item.name} and it's getting out of stock ( #{item.stock} )", email.body.encoded
  end
end