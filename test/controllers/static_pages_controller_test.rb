require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", BASE_TITLE
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{BASE_TITLE}"
  end
end
