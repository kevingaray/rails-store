require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  test 'customer can CREATE like item' do
    token = token_login_as_customer
    id = FactoryBot.create(:item).id

    post "/api/v1/items/#{id}/likes", headers: { 'Authorization' => token }
    perform_enqueued_jobs
    get "/api/v1/items/#{id}"
    assert_equal 1, JSON.parse(response.body)['data']['likes']
    assert_response :success
  end

  test 'customer can DESTROY like item' do
    token = token_login_as_customer
    id = FactoryBot.create(:item).id

    post "/api/v1/items/#{id}/likes", headers: { 'Authorization' => token }
    perform_enqueued_jobs
    get "/api/v1/items/#{id}"
    assert_equal 1, JSON.parse(response.body)['data']['likes']
    assert_response :success

    delete "/api/v1/items/#{id}/likes", headers: { 'Authorization' => token }
    perform_enqueued_jobs
    get "/api/v1/items/#{id}"
    assert_equal 0, JSON.parse(response.body)['data']['likes']
    assert_response :success
  end

  private

  def token_login_as_customer
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    JSON.parse(response.body)['token']
  end

end
