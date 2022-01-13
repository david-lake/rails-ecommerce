require 'test_helper'

class BagItemTest < ActiveSupport::TestCase
  def setup
    product = products(:one)
    shopping_bag = ShoppingBag.create
    @bag_item = shopping_bag.bag_items.build(product: product, quantity: 3)
  end

  test "should be valid" do
    assert @bag_item.valid?
  end

  test "should have shopping_bag_id" do
    @bag_item.shopping_bag_id = nil
    assert_not @bag_item.valid?
  end

  test "should have product_id" do
    @bag_item.product_id = nil
    assert_not @bag_item.valid?
  end

  test "should have quantiy" do
    @bag_item.quantity = nil
    assert_not @bag_item.valid?
  end

  test "Quantity should be an integer greater than 0" do
    @bag_item.quantity = "a"
    assert_not @bag_item.valid?
    @bag_item.quantity = "1.2"
    assert_not @bag_item.valid?
    @bag_item.quantity = "0"
    assert_not @bag_item.valid?
  end
end
