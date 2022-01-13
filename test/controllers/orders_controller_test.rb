require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  def setup
    @admin = users(:david)
    @non_admin = users(:james)
    @order = orders(:one)
    @order_in_progress = orders(:in_progress)
    @order_confirmed = orders(:confirmed)
  end

  test "should redirect index when not logged_in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in as admin" do
    login_as @non_admin
    get :index
    assert_redirected_to root_url
  end

  test "should get index when logged in as admin" do
    login_as @admin
    get :index
    assert_response :success
    assert_select "title", "Orders | #{BASE_TITLE}"
  end

  test "should redirect order history when not logged in" do
    get :order_history
    assert_redirected_to login_url
  end

  test "should get order history when logged in" do
    login_as @non_admin
    get :order_history
    assert_response :success
    assert_select "title", "My orders | #{BASE_TITLE}"
  end

  test "should redirect show when not logged_in" do
    get :show, params: { id: @order.id }
    assert_redirected_to login_url
  end

  test "should redirect show when order is in progress" do
    login_as @non_admin
    get :show, params: { id: @order_in_progress.id }
    assert_redirected_to root_url
  end

  test "should get show when logged in as correct user" do
    login_as @non_admin
    get :show, params: { id: @order.id }
    assert_response :success
    assert_select "title", "Order | #{BASE_TITLE}"
  end

  test "should get show when logged in as admin" do
    login_as @admin
    get :show, params: { id: @order.id }
    assert_response :success
    assert_select "title", "Order | #{BASE_TITLE}"
  end

  test "should redirect new when not logged_in" do
    get :new
    assert_redirected_to login_url
  end

  test "should redirect new when nothing in bag" do
    login_as @admin
    get :new
    assert_redirected_to root_url
  end

  test "should redirect new if order already in progress" do
    login_as @non_admin
    get :new
    assert_redirected_to order_summary_url(@order_in_progress)
  end

  test "should get new when logged in, has bag items, and no order in progress" do
    login_as users(:lana)
    get :new
    assert_response :success
    assert_select "title", "Checkout | #{BASE_TITLE}"
  end

  test "should redirect create when not logged_in" do
    assert_no_difference 'Order.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  test "should redirect summary when not logged in" do
    get :summary, params: { id: @order_in_progress.id }
    assert_redirected_to login_url
  end

  test "should redirect summary when order not in progress" do
    login_as @non_admin
    get :summary, params: { id: @order.id }
    assert_redirected_to root_url
  end

  test "should get summary when order in progress" do
    login_as @non_admin
    get :summary, params: { id: @order_in_progress.id }
    assert_response :success
    assert_select "title", "Order Summary | #{BASE_TITLE}"
  end

  test "should redirect payment when not logged in" do
    assert_no_difference '@order_in_progress.status' do
      patch :payment, params: { id: @order_in_progress.id }
    end
    assert_redirected_to login_url
  end

  test "should redirect confirmation when not logged in" do
    get :confirmation, params: { id: @order.id }
    assert_redirected_to login_url
  end

  test "should redirect confirmation only once after payment" do
    login_as @non_admin
    get :confirmation, params: { id: @order_in_progress.id }
    assert_redirected_to root_url
    get :confirmation, params: { id: @order_confirmed.id }
    assert_redirected_to root_url
  end

  test "should get confirmation when logged in" do
    login_as @non_admin
    get :confirmation, params: { id: @order.id }
    assert_response :success
    assert_select "title", "Order Confirmed | #{BASE_TITLE}"
  end

  test "should redirect update when not logged in" do
    assert_no_difference '@order.status' do
      patch :update, params: { id: @order.id }
    end
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in as admin" do
    login_as @non_admin
    assert_no_difference '@order.status' do
      patch :update, params: { id: @order.id }
    end
    assert_redirected_to root_url
  end
end
