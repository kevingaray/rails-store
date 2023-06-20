require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest

  test 'login in as customer in api' do
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email , password: user.password }
    assert_response :success
  end

  test 'login as admin in api' do
    admin = FactoryBot.create(:admin_user)
    post '/api/v1/auth/login', params: { email: admin.email , password: admin.password }
    assert_equal true, JSON.parse(response.body)['admin']
    assert_response :success
  end

  test 'should get INDEX json no autentication' do
    get '/api/v1/items'
    assert_response :success
  end

  test 'should not SHOW item json with no autentication' do
    item_id = FactoryBot.create(:item).id
    get "/api/v1/items/#{item_id}"
    assert_response :unauthorized
  end

  test 'admin can CREATE item api' do
    token = token_login_as_admin
    assert_difference('Item.count') do
      post '/api/v1/items',
           headers: { 'Authorization' => token },
           params: { item: { name: 'uva test', price: 3.4, stock: 6 } }
    end
    assert_response :success
  end

  test 'admin can DELETE an item api' do
    token = token_login_as_admin
    item_id = FactoryBot.create(:item).id

    assert_difference('Item.where(deleted_at: nil).count', -1) do
      delete "/api/v1/items/#{item_id}", headers: { 'Authorization' => token }
    end
    assert_response :success
  end

  test 'admin can UPDATE an item api' do
    token = token_login_as_admin
    item = FactoryBot.create(:item)

    put "/api/v1/items/#{item.id}", 
      headers: { 'Authorization' => token },
      params: { item: { name: 'uva test', price: 3.4, stock: 6 } }

    assert_response :success

    get "/api/v1/items/#{item.id}", headers: { 'Authorization' => token }
    assert_equal 'uva test', JSON.parse(response.body)['data']['name']
    assert_equal "3.4", JSON.parse(response.body)['data']['price']
    assert_equal 6, JSON.parse(response.body)['data']['stock']
    assert_response :success
  end

  test "support can't UPDATE an item api" do
    token = token_login_as_support
    item = FactoryBot.create(:item)

    put "/api/v1/items/#{item.id}", 
      headers: { 'Authorization' => token },
      params: { item: { name: 'uva test', price: 3.4, stock: 6 } }

    assert_response :unauthorized
  end

  private

  def token_login_as_admin
    admin = FactoryBot.create(:admin_user)
    post '/api/v1/auth/login', params: { email: admin.email, password: admin.password }
    JSON.parse(response.body)['token']
  end

  def token_login_as_support
    support = FactoryBot.create(:support_user)
    post '/api/v1/auth/login', params: { email: support.email, password: support.password }
    JSON.parse(response.body)['token']
  end

end
