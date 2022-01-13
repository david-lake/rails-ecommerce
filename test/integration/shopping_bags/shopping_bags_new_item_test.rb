require 'test_helper'

class NewBagItemTest < ActionDispatch::IntegrationTest

  def setup
    @user     = users(:david)
    @product  = products(:one)
    @product2 = products(:two)
  end

  test "add products to bag as guest" do
    get product_path(@product)
    assert_difference 'BagItem.count', 1 do
      post bag_items_path, params: { product_id: @product.id, bag_item: { quantity: 1 } }
    end
    bag = assigns(:shopping_bag)
    assert_nil bag.user_id
    assert_not_nil session['shopping_bag']
    assert_difference 'bag.bag_items.count', 1 do
      post bag_items_path, params: { product_id: @product2.id, bag_item: { quantity: 1 } }
    end
    follow_redirect!
    assert_template 'products/show'
    assert bag.bag_items.count == 2
    assert_select "a[href=?]", shopping_bag_path, text: "Bag ( 2 )"
  end

  test "add products to bag as logged in user" do
    login_as @user
    get product_path(@product)
    assert_difference 'BagItem.count', 1 do
      post bag_items_path, params: { product_id: @product.id, bag_item: { quantity: 1 } }
    end
    bag = assigns(:shopping_bag)
    assert bag.user_id == @user.id
    assert_nil session['shopping_bag']
    assert_difference '@user.shopping_bag.bag_items.count', 1 do
      post bag_items_path, params: { product_id: @product2.id, bag_item: { quantity: 1 } }
    end
    follow_redirect!
    assert_template 'products/show'
    assert @user.shopping_bag.bag_items.count == 2
    assert_select "a[href=?]", shopping_bag_path, text: "Bag ( 2 )"
  end

  test "adding item twice updates product quantity" do
    assert_difference 'BagItem.count', 1 do
      post bag_items_path, params: { product_id: @product.id, bag_item: { quantity: 1 } }
      post bag_items_path, params: { product_id: @product.id, bag_item: { quantity: 2 } }
    end
    follow_redirect!
    assert_template 'products/show'
    bag = ShoppingBag.find(session['shopping_bag'])
    bag_item = bag.bag_items.find_by(product_id: @product.id)
    assert bag_item.quantity == 3
    assert_select "a[href=?]", shopping_bag_path, text: "Bag ( 1 )"
  end

  test "add products as a guest then login" do
    get product_path(@product)
    assert_difference 'BagItem.count', 1 do
      post bag_items_path, params: { product_id: @product.id, bag_item: { quantity: 1 } }
    end
    bag_id = assigns(:shopping_bag).id
    login_as @user
    follow_redirect!
    assert @user.shopping_bag.bag_items.count == 1
    assert_select "a[href=?]", shopping_bag_path, text: "Bag ( 1 )"
    assert_nil ShoppingBag.find_by(id: bag_id)
    assert_nil session['shopping_bag']
  end

  test "attempt to add more than available stock" do
    get product_path(@product)
    assert_no_difference 'BagItem.count' do
      post bag_items_path, params: { product_id: @product.id,
                                     bag_item: { quantity: @product.quantity + 1 } }
    end
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
    assert_select ".alert-danger"
  end

  test "attempt to add more than available stock when item is already in bag" do
    get product_path(@product)
    assert_difference 'BagItem.count', 1 do
      post bag_items_path, params: { product_id: @product.id,
                                     bag_item: { quantity: @product.quantity } }
    end
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
    assert_select ".alert-success"
    assert_no_difference 'BagItem.count' do
      post bag_items_path, params: { product_id: @product.id,
                                     bag_item: { quantity: 1 } }
    end
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
    assert_select ".alert-danger"
  end
end
