require 'test_helper'

class EditProductTest < ActionDispatch::IntegrationTest
  def setup
    login_as users(:david)
    @product = products(:one)
  end

  test "unsuccessful edit" do
    get edit_product_path(@product)
    assert_template 'products/edit'
    patch product_path(@product), params: {
                                    product: {
                                      name:  "",
                                      price: nil,
                                      quantity: nil,
                                    }
                                  }
    assert_template 'products/edit'
  end

  test "successful edit" do
    get edit_product_path(@product)
    assert_template 'products/edit'
    patch product_path(@product), params: {
                                    product: {
                                      name:  "Edited Product",
                                      price: 3.50,
                                      quantity: 50,
                                    }
                                  }
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
  end
end
