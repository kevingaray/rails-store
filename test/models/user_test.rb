require "test_helper"

class UserTest < ActiveSupport::TestCase

  test 'user should have first_name' do
    user = build(:user)
    user.first_name = ""
    assert_not user.valid?
  end

  test 'user should have last_name' do
    user = build(:user)
    user.last_name = ""
    assert_not user.valid?
  end

  test 'user should have email' do
    user = build(:user)
    user.email = ""
    assert_not user.valid?
  end
  
end
