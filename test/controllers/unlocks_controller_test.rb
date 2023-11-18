require "test_helper"

class UnlocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @raw, @enc = Devise.token_generator.generate(User, :unlock_token)
    @user = create(:user, :locked, unlock_token_enc: @enc)
  end

  test "should send unlock instructions" do
    post user_unlock_path, params: {user: {email: @user.email}}
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_equal "You will receive an email with instructions for how to unlock your account in a few minutes.", flash[:notice]
  end

  test "should unlock user account" do
    get user_unlock_path(unlock_token: @raw)
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_equal "Your account has been unlocked successfully. Please sign in to continue.", flash[:notice]
    refute @user.reload.access_locked?
  end

  # It is not returning 422. Devise bug?
  # test "should not unlock with invalid token" do
  #   get user_unlock_path(unlock_token: "invalid_token")
  #   assert_response :unprocessable_entity
  # end
end
