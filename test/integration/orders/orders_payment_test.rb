require 'test_helper'

class CheckoutTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:mallory)
    @bag = shopping_bags(:bag_three)
    @order = orders(:three)
  end

  test "pay now transfers bag items to order" do
    # login and attempt to checkout
    login_as @user
    get order_summary_path(@order)
    assert_template "orders/summary"
    assert_difference "@order.order_items.count", @bag.bag_items.count do
      patch order_payment_path(@order)
    end
    follow_redirect!
    assert_equal 2, ActionMailer::Base.deliveries.size
    assert_template "orders/confirmation"
    assert @bag.bag_items.count == 0
  end

=begin
  test "checkout including not enough stock and send empty stock email" do
    login_as @user
    get shopping_bag_path
    assert_not flash.empty?
    assert_no_difference "@user.orders.count" do
      post orders_path
    end
    # redirected back to bag as not enough stock
    follow_redirect!
    assert_template "shopping_bags/show"
    assert_not flash.empty?
    # remove the item that has no stock
    delete bag_item_path(bag_items(:no_stock))
    # add a new item set quantity as exact amount available
    post bag_items_path, params: {
      product_id: Product.last.id, bag_item: { quantity: Product.last.quantity }
    }
    # checkout out again
    assert_difference "@user.orders.count", 1 do
      post orders_path
    end
    # order confirmed and all emails sent
    follow_redirect!
    assert_equal 3, ActionMailer::Base.deliveries.size
    assert_template "checkouts/confirmation"
    assert_match "Thank you for your order", response.body
  end
=end
end
