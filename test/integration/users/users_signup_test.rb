require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,
        params: {
          user: {
            first_name: "",
            last_name: "",
            email: "example@invalid",
            password: "foo",
            password_confirmation: "bar"
          }
        }
    end
    assert_template 'users/new'
  end

  test "valid signup information with account activation" do
     get signup_path
     assert_difference 'User.count', 1 do
       post users_path, params: {
                          user: {
                            first_name: "Example",
                            last_name:  "User",
                            email: "user@example.com",
                            password:              "password",
                            password_confirmation: "password"
                          }
                        }
     end
     assert_equal 1, ActionMailer::Base.deliveries.size
     user = assigns(:user)
     assert_not user.activated?
     # Try to log in before activation.
     login_as(user)
     assert_not is_logged_in?
     # Invalid activation token
     get edit_account_activation_path("invalid token")
     assert_not is_logged_in?
     # Valid token, wrong email
     get edit_account_activation_path(user.activation_token, email: 'wrong')
     assert_not is_logged_in?
     # Valid activation token and email
     get edit_account_activation_path(user.activation_token, email: user.email)
     assert user.reload.activated?
     follow_redirect!
     assert_template 'static_pages/home'
     assert is_logged_in?
   end
end
