require 'test_helper'

class NewProductTest < ActionDispatch::IntegrationTest

  def setup
    login_as users(:david)
    @category = categories(:cards)
    @sub_category = sub_categories(:birthday)
  end

  test "invalid new product" do
    get new_product_path
    assert_template 'products/new'
    assert_no_difference 'Product.count' do
      post products_path, params: { product: { category_id: @category.id,
                                               sub_category_id: @sub_category.id,
                                               name: "",
                                               price: nil,
                                               quantity: nil } }
    end
    assert_template 'products/new'
  end

  test "valid new product" do
    get new_product_path
    assert_difference 'Product.count', 1 do
      post products_path, params: { product: { category_id: @category.id,
                                               sub_category_id: @sub_category.id,
                                               name: "Test Product",
                                               price: 2.55,
                                               quantity: 5 } }
    end
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
  end
end
