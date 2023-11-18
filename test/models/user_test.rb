require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test "should validate presence of email" do
    assert_matcher validate_presence_of(:email), @user
  end

  test "should validate presence of password" do
    assert_matcher validate_presence_of(:password), @user
  end

  test "should validate presence of password_confirmation" do
    assert_matcher validate_presence_of(:password_confirmation), @user
  end

  test "should validate uniqueness of email" do
    assert_matcher validate_uniqueness_of(:email), @user
  end
end
