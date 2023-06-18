require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest

  def setup
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    @token = JSON.parse(response.body)['token']
    @item = FactoryBot.create(:item)
  end

  test 'customer can see their orders' do
    get '/api/v1/orders', headers: { 'Authorization' => @token }
    assert_response :success
  end

  test 'customer checkout and see order' do
    # added a cart
    post '/api/v1/line_items', headers: { 'Authorization' => @token },
      params: { line_item: { item_id: @item.id, quantity: 5 } }
    assert_response :success

    # checkout
    post '/api/v1/orders', headers: { 'Authorization' => @token }
    order_id = JSON.parse(response.body)['id']
    assert_response :success

    # see order
    get "/api/v1/orders/#{order_id}", headers: { 'Authorization' => @token }

    assert_equal @item.name, JSON.parse(response.body)['data'][0]['items'][0]['name']
    assert_equal 5, JSON.parse(response.body)['data'][0]['items'][0]['quantity']
    assert_response :success
  end

end
