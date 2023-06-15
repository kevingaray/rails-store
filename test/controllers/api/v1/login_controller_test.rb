require 'test_helper'

class LoginItemsControllerTest < ActionDispatch::IntegrationTest

  test 'login in as customer in api' do
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    assert_response :success
  end

  test 'login as admin in api' do
    admin = FactoryBot.create(:admin_user)
    post '/api/v1/auth/login', params: { email: admin.email, password: admin.password }
    assert_equal true, JSON.parse(response.body)['admin']
    assert_response :success
  end

end
