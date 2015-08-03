require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "test_user", password: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "username should not be longer than 50 characters" do
    @user.username = "long_name" * 50
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should be longer than 6 characters" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end
end
