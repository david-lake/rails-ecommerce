require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get login_path
    assert_response :success
    assert_select "title", "Login | #{BASE_TITLE}"
    assert_template "sessions/new"
  end
end
