require 'test_helper'

class IndexOrdersTest < ActionDispatch::IntegrationTest

  def setup
    @order = orders(:one)
    ActionMailer::Base.deliveries.clear
  end

  test "should index all orders including mark order as dispatched" do
    login_as users(:david)
    get orders_path
    assert_template 'orders/index'
    assert_select 'div.pagination'
    Order.all.where("status >= ?", "1").paginate(page: 1).each do |order|
      assert_select 'a[href=?]', order_path(order), text: "View"
    end
    patch order_path(@order)
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert @order.reload.status == 3
  end
end
