require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  def setup
    @admin     = users(:david)
    @non_admin = users(:james)
    @product   = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Shop all | #{BASE_TITLE}"
  end

  test "should get show" do
    get :show, params: { id: @product.id }
    assert_response :success
    assert_select "title", "#{@product.name} | #{BASE_TITLE}"
  end

  test "should redirect new when not logged_in" do
    get :new
    assert_redirected_to login_url
  end

  test "should redirect new when logged_in as non-admin" do
    login_as @non_admin
    get :new
    assert_redirected_to root_url
  end

  test "should get new when logged in as admin" do
    login_as @admin
    get :new
    assert_response :success
    assert_select "title", "New Product | #{BASE_TITLE}"
  end

  test "should redirect create when not logged_in" do
    assert_no_difference 'Product.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  test "should redirect create when logged_in as non-admin" do
    login_as @non_admin
    assert_no_difference 'Product.count' do
      post :create
    end
    assert_redirected_to root_url
  end

  test "should redirect edit when not logged_in" do
    get :edit, params: { id: @product.id }
    assert_redirected_to login_url
  end

  test "should redirect edit when logged_in as non-admin" do
    login_as @non_admin
    get :edit, params: { id: @product.id }
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Product.count' do
      delete :destroy, params: { id: @product }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    login_as @non_admin
    assert_no_difference 'Product.count' do
      delete :destroy, params: { id: @product }
    end
    assert_redirected_to root_url
  end
end
