require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:david)
    @non_admin = users(:james)
  end

  test "layout links when not logged in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", products_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_us_path
    assert_select "a[href=?]", shopping_bag_path
    assert_select "a[href=?]", login_path
  end

  test "layout links when logged in as non-admin" do
    get login_path
    login_as @non_admin
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", products_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_us_path
    assert_select "a[href=?]", shopping_bag_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", my_orders_path
    assert_select "a[href=?]", edit_user_path(@non_admin), count: 1
    assert_select "a[href=?]", logout_path, count: 1
  end

  test "layout links when logged in as admin" do
    get login_path
    login_as @admin
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", products_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_us_path
    assert_select "a[href=?]", new_product_path
    assert_select "a[href=?]", orders_path
    assert_select "a[href=?]", shopping_bag_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", my_orders_path
    assert_select "a[href=?]", edit_user_path(@admin), count: 1
    assert_select "a[href=?]", logout_path, count: 1
  end
end
