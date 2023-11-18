require "test_helper"

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, confirmed_at: nil)
  end

  test "user should receive confirmation instructions" do
    assert_emails 1 do
      post user_confirmation_path, params: {user: {email: @user.email}}
    end
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_equal "You will receive an email with instructions for how to confirm your email address in a few minutes.", flash[:notice]
  end

  test "user should be able to confirm account" do
    get user_confirmation_path(confirmation_token: @user.confirmation_token)
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_equal "Your email address has been successfully confirmed.", flash[:notice]
  end
end
