require 'test_helper'

class OrderHistoryTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:james)
  end

  test "should get users order history" do
    login_as @user
    get my_orders_path
    assert_template 'orders/order_history'
    assert_select 'div.pagination'
    @user.orders.where("status >= ?", "1").paginate(page: 1).each do |order|
      assert_select 'a[href=?]', order_path(order), text: "View"
      assert_select 'a[href=?]', order_path(order), text: "Mark as dispatched", count: 0
    end
  end
end
