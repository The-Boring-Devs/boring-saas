require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_params = {
      user: attributes_for(:user)
    }
  end

  test "should create a new user account" do
    assert_difference "User.count", 1 do
      post user_registration_path, params: @user_params
    end

    assert_redirected_to root_path
  end

  test "should not create user with invalid email" do
    @user_params[:user][:email] = "invalid_email"
    assert_no_difference "User.count" do
      post user_registration_path, params: @user_params
    end
  end

  test "should not create user with password confirmation mismatch" do
    @user_params[:user][:password_confirmation] = "different"
    assert_no_difference "User.count" do
      post user_registration_path, params: @user_params
    end
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path
    assert_redirected_to new_user_session_path
  end

  test "should allow user to edit their own account" do
    sign_in create(:user)
    get edit_user_registration_path
    assert_response :success
  end

  test "should update user account" do
    user = create(:user)
    sign_in user
    patch user_registration_path, params: {user: {email: "newemail@example.com", current_password: user.password}}
    assert_redirected_to root_path
    user.reload
    refute_equal "newemail@example.com", user.email
    assert_equal "newemail@example.com", user.unconfirmed_email

    user.confirm
    user.reload
    assert_equal "newemail@example.com", user.email
    assert_nil user.unconfirmed_email
  end

  test "should delete user account" do
    sign_in create(:user)
    assert_difference "User.count", -1 do
      delete user_registration_path
    end
    assert_redirected_to root_path
  end
end
