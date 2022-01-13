require 'test_helper'

class DeleteProductTest < ActionDispatch::IntegrationTest

  def setup
    login_as users(:david)
    @product = Product.create(category: categories(:cards),
                              sub_category: sub_categories(:birthday),
                              name: "Test Product",
                              price: 2.55,
                              quantity: 5)
  end

  test "admins can delete products" do
    get product_path @product
    assert_difference 'Product.count', -1 do
      delete product_path @product
    end
    follow_redirect!
    assert_template 'products/index'
    assert_not flash.empty?
  end
end
