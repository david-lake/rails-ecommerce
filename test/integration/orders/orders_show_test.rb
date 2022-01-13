require 'test_helper'

class ShowOrderTest < ActionDispatch::IntegrationTest
  test "should show an order" do
    login_as users(:david)
    order = orders(:one)
    get order_path(order)
    assert_template 'orders/show'
    order.order_items.each do |item|
      assert_select 'a[href=?]', product_path(item.product), text: item.product.name
    end
  end
end
