require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get items_path
    assert_response :success
  end

  test 'should show item' do
    item = FactoryBot.create(:item)
    get item_path(item)
    assert_response :success
  end

  test 'should get new only to admin' do
    admin = FactoryBot.create(:admin_user)
    sign_in(admin)

    get new_item_url
    assert_response :success
  end

  test 'should reject new to no admin' do
    user = FactoryBot.create(:user)
    sign_in(user)

    get new_item_url
    assert_response :redirect
  end

end
