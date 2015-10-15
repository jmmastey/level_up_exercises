require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "no account creation with invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "user@foo",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "account created with valid information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example User",
                                            email: "user.name@example.com",
                                            password: "foobar1234",
                                            password_confirmation: "foobar1234" }
    end
    assert_template 'users/show'
    assert_select 'div.alert-success'
  end
end
