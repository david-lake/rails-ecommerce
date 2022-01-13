require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  def setup
    order = orders(:one)
    product = products(:one)
    @order_item = order.order_items.build(product: product, quantity: 2)
  end

  test "Order item should be valid" do
    assert @order_item.valid?
  end

  test "Product id should be present" do
    @order_item.product_id = nil
    assert_not @order_item.valid?
  end

  test "quantity should be present and an integer" do
    @order_item.quantity = nil
    assert_not @order_item.valid?
    @order_item.quantity = 1.5
    assert_not @order_item.valid?
  end
end
