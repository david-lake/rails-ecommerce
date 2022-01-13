require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:david)
    @other_user = users(:james)
  end

  test "unsuccessful edit" do
    login_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
                              user: {
                                first_name:  "",
                                last_name: "",
                                email: "foo@invalid",
                                password: "foo",
                                password_confirmation: "bar"
                              }
                            }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    login_as(@user)
    assert_redirected_to edit_user_path(@user)
    first_name = "Test"
    last_name = "User"
    email = "foo@exmaple.com"
    patch user_path(@user), params: {
                              user: {
                                first_name: first_name,
                                last_name: last_name,
                                email: email,
                                password: "",
                                password_confirmation: ""
                              }
                            }
    follow_redirect!
    assert_not flash.empty?
    assert_template 'users/edit'
    @user.reload
    assert_equal @user.first_name, first_name
    assert_equal @user.last_name,  last_name
    assert_equal @user.email,      email
  end
end
