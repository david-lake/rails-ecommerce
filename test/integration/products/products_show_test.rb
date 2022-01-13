require 'test_helper'

class ShowProductTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:david)
    @non_admin = users(:james)
    @product   = products(:one)
    @product2  = products(:no_stock)
  end

  test "show product with no edit or delete links" do
    get product_path(@product)
    assert_template 'products/show'
    assert_match @product.name,           response.body
    assert_match @product.description,    response.body
    assert_match '%.2f' % @product.price, response.body
    assert_select "#new_bag_item"
    assert_select 'a', text: 'Edit', count: 0
    assert_select 'a', text: 'Delete', count: 0
  end

  test "show product with no edit or delete links for non-admins" do
    login_as @non_admin
    get product_path(@product)
    assert_template 'products/show'
    assert_match @product.name,           response.body
    assert_match @product.description,    response.body
    assert_match '%.2f' % @product.price, response.body
    assert_select "#new_bag_item"
    assert_select 'a', text: 'Edit', count: 0
    assert_select 'a', text: 'Delete', count: 0
  end

  test "show product for admin users" do
    login_as @admin
    get product_path(@product)
    assert_template 'products/show'
    assert_match @product.name,           response.body
    assert_match @product.description,    response.body
    assert_match '%.2f' % @product.price, response.body
    assert_select "#new_bag_item"
    assert_select 'a[href=?]', edit_product_path(@product), text: 'Edit'
    assert_select 'a[href=?]', product_path(@product), text: 'Delete', method: :delete
  end

  test "show product with no stock" do
    get product_path(@product2)
    assert_template 'products/show'
    assert_match "Currently out of stock", response.body
    assert_select "#new_bag_item", count: 0
  end
end
