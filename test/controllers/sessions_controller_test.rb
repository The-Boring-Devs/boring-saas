require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "user can log in with valid credentials" do
    post user_session_path, params: {user: {email: @user.email, password: @user.password}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal root_path, path
  end

  test "user cannot log in with invalid credentials" do
    post user_session_path, params: {user: {email: @user.email, password: "wrongpassword"}}
    assert_response :unprocessable_entity
    assert_not flash.empty?
  end
end
