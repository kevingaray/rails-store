require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'user should have first_name' do
    user = User.new
    user.email = 'test@test'
    user.password = 'secure'
    user.last_name = 'last_name'
    assert_not user.valid?
  end

  test 'user should have last_name' do
    user = User.new
    user.email = 'test@test'
    user.password = 'secure'
    user.first_name = 'first_name'
    assert_not user.valid?
  end

  test 'user should have email' do
    user = User.new
    user.password = 'secure'
    user.first_name = 'first_name'
    user.last_name = 'last_name'
    assert_not user.valid?
  end
  
end
