require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:david)
    @other_user = users(:james)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | #{BASE_TITLE}"
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @user }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, params: { id: @user, user: { first_name: @user.first_name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    login_as @other_user
    get :edit, params: { id: @user }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
