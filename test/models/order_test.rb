require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = users(:james).orders.build(
      status: 0,
      shipping_address: addresses(:one),
      billing_address:  addresses(:two)
    )
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "should have a user association" do
    @order.user_id = nil
    assert_not @order.valid?
  end

  test "should have a status" do
    @order.status = nil
    assert_not @order.valid?
  end
end
