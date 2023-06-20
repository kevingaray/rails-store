require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    @token = JSON.parse(response.body)['token']
    @item_id = FactoryBot.create(:item).id
  end

  test 'customer can CREATE like item' do
    post "/api/v1/items/#{@item_id}/likes", headers: { 'Authorization' => @token }
    perform_enqueued_jobs
    get "/api/v1/items/#{@item_id}", headers: { 'Authorization' => @token }
    assert_equal 1, JSON.parse(response.body)['data']['likes']
    assert_response :success
  end

  test 'customer can DESTROY like item' do
    post "/api/v1/items/#{@item_id}/likes", headers: { 'Authorization' => @token }
    perform_enqueued_jobs
    get "/api/v1/items/#{@item_id}", headers: { 'Authorization' => @token }
    assert_equal 1, JSON.parse(response.body)['data']['likes']
    assert_response :success

    delete "/api/v1/items/#{@item_id}/likes", headers: { 'Authorization' => @token }
    perform_enqueued_jobs
    get "/api/v1/items/#{@item_id}", headers: { 'Authorization' => @token }
    assert_equal 0, JSON.parse(response.body)['data']['likes']
    assert_response :success
  end

end
