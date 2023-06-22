require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    user = FactoryBot.create(:user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    @token_user = JSON.parse(response.body)['token']

    admin = FactoryBot.create(:admin_user)
    post '/api/v1/auth/login', params: { email: admin.email, password: admin.password }
    @token_admin = JSON.parse(response.body)['token']
    
    @commentable_user_id = FactoryBot.create(:user).id
  end

  test 'comment process' do
    # verify 0 comments on commentable user
    assert_equal 0, User.find(@commentable_user_id).comments.size

    # create comment
    post "/api/v1/users/#{@commentable_user_id}/comments",
         headers: { 'Authorization' => @token_user },
         params: { comment: { body: 'great guy', rate: 3 } }
    assert_response :success

    # # verify a comment is created
    assert_equal 1, User.find(@commentable_user_id).comments.size

    # # verify that comment is not approved
    comment = User.find(@commentable_user_id).comments.last
    assert_equal false,  comment.approved

    # # proccess to aprrove that comment
    post "/api/v1/users/#{@commentable_user_id}/comments/#{comment.id}/approve",
          headers: { 'Authorization' => @token_admin }
    assert_response :success

    comment = User.find(@commentable_user_id).comments.last
    assert_equal true, comment.approved
  end
end
