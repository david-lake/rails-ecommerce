require 'test_helper'

class IndexBagItemsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:james)
    @bag_items = @user.shopping_bag.bag_items
    login_as @user
    get shopping_bag_path
  end

  test "show bag including delete and update items" do
    assert_template "shopping_bags/show"
    @bag_items.each do |item|
      assert_select 'a[href=?]', product_path(item.product), text: item.product.name
      assert_select "#bag_item_quantity[value='#{item.quantity}']"
      assert_match  '%.2f' % item.product.price, response.body
      assert_select 'a[href=?]', bag_item_path(item), text: 'Remove', method: :delete
    end
    assert_match "£9.50", response.body
    patch bag_item_path(bag_items(:one)), params: { bag_item: { quantity: 2 } }
    assert bag_items(:one).reload.quantity == 2
    follow_redirect!
    assert_template "shopping_bags/show"
    assert_not flash.empty?
    assert_match "£12.00", response.body
    assert_difference '@bag_items.count', -1 do
      delete bag_item_path(bag_items(:three))
    end
    follow_redirect!
    assert_template "shopping_bags/show"
    assert_not flash.empty?
    assert_match "£7.00", response.body
  end

  test "attempt to update with more than available stock" do
    quantity = bag_items(:two).product.quantity + 1
    patch bag_item_path(bag_items(:two)), params: { bag_item: { quantity: quantity } }
    follow_redirect!
    assert_template "shopping_bags/show"
    assert_not flash.empty?
    assert bag_items(:two).reload.quantity == 1
  end
end
