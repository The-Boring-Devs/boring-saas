require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "user should receive reset password instructions" do
    assert_emails 1 do
      post user_password_path, params: {user: {email: @user.email}}
    end
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_equal "You will receive an email with instructions on how to reset your password in a few minutes.", flash[:notice]
  end

  test "user should be able to change password" do
    original_password = @user.encrypted_password
    token = @user.send_reset_password_instructions
    patch user_password_path, params: {
      user: {
        reset_password_token: token,
        password: "newpassword123"
      }
    }
    assert_redirected_to root_path
    follow_redirect!
    assert_equal "Your password has been changed successfully. You are now signed in.", flash[:notice]
    refute_equal original_password, @user.reload.encrypted_password
  end
end
