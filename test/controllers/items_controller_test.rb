require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'no user can get to item index' do
    get items_path
    assert_response :success
  end

  test 'no user can get to show item' do
    item = FactoryBot.create(:item)
    get item_path(item)
    assert_response :success
  end

  test 'only admin can get to new item page' do
    admin = FactoryBot.create(:admin_user)
    sign_in(admin)

    get new_item_url
    assert_response :success
  end

  test 'no admin cant get to new item page' do
    user = FactoryBot.create(:user)
    sign_in(user)

    get new_item_url
    assert_response :redirect
  end

  test 'admin can create item' do
    admin = FactoryBot.create(:admin_user)
    sign_in(admin)

    assert_difference('Item.count') do
      post items_url, params: { item: { name: 'Red tomate', price: 14, stock: 5, tags: ''  } }
    end
    assert_response :redirect
  end

  test "customer can't create item" do
    user = FactoryBot.create(:user)
    sign_in(user)

    assert_difference('Item.count', 0) do
      post items_url, params: { item: { name: 'Red tomate', price: 14, stock: 5, tags: ''  } }
    end
    assert_response :redirect
  end

  test 'admin should get edit' do
    admin = FactoryBot.create(:admin_user)
    sign_in(admin)
    item = FactoryBot.create(:item)

    get edit_item_path(item)
    assert_response :success
  end

  test 'should destroy item' do
    admin = FactoryBot.create(:admin_user)
    sign_in(admin)
    item = FactoryBot.create(:item)

    assert_difference('Item.where(deleted_at: nil).count', -1) do
      delete item_path(item)
    end

    assert_response :redirect
  end

  test 'admin update item' do
    admin = FactoryBot.create(:admin_user)
    sign_in(admin)
    item = FactoryBot.create(:item)

    patch item_url(item), params: { item: { name: 'Green tomate', price: 17, stock: 5, tags: 'blue' } }
    assert_redirected_to item_url(item)
  end


end
