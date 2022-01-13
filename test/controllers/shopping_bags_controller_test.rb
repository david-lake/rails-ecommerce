require 'test_helper'

class ShoppingBagsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
    assert_select "title", "Shopping Bag | #{BASE_TITLE}"
  end
end
