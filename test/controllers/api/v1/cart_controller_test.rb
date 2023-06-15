require 'test_helper'

class CartControllerTest < ActionDispatch::IntegrationTest

  test 'show empty cart at initialized' do
    token = token_login_as_customer
    get '/api/v1/carts',
        headers: { 'Authorization' => token }
    assert_equal 0, JSON.parse(response.body)['data']['items'].size
    assert_response :success
  end

  test 'user can add item to a cart' do
    token = token_login_as_customer
    id = FactoryBot.create(:item).id

    post '/api/v1/line_items',
         headers: { 'Authorization' => token },
         params: { line_item: { item_id: id, quantity: 5 } }

    assert_equal 1, JSON.parse(response.body)['data']['items'].size
    assert_response :success
  end

  test "user can't add item in a quantity more than stock to a cart" do
    token = token_login_as_customer
    id = FactoryBot.create(:item).id

    post '/api/v1/line_items',
         headers: { 'Authorization' => token },
         params: { line_item: { item_id: id, quantity: 100 } }

    assert_response :not_found
  end

  test 'user cant delete item in cart' do
    token = token_login_as_customer
    id = FactoryBot.create(:item).id

    post '/api/v1/line_items',
         headers: { 'Authorization' => token },
         params: { line_item: { item_id: id, quantity: 2 } }

    assert_equal 1, JSON.parse(response.body)['data']['items'].size
    assert_response :success

    delete '/api/v1/line_items',
           headers: { 'Authorization' => token },
           params: { item_id: id }
    assert_response :success
    
    get '/api/v1/carts', headers: { 'Authorization' => token }
    assert_equal 0, JSON.parse(response.body)['data']['items'].size
    assert_response :success
  end

  test 'user can delete actual cart' do
    # create cart and add item
    token = token_login_as_customer
    id = FactoryBot.create(:item).id

    post '/api/v1/line_items',
         headers: { 'Authorization' => token },
         params: { line_item: { item_id: id, quantity: 2 } }

    assert_equal 1, JSON.parse(response.body)['data']['items'].size
    assert_response :success

    # delete all cart
    delete '/api/v1/carts',
           headers: { 'Authorization' => token }
    assert_response :success

    # show empty cart
    get '/api/v1/carts',
        headers: { 'Authorization' => token }
    assert_equal 0, JSON.parse(response.body)['data']['items'].size
  end

  private

  def token_login_as_customer
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    JSON.parse(response.body)['token']
  end

end
