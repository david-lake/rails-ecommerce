require 'test_helper'

class IndexProductsTest < ActionDispatch::IntegrationTest
  test "should get all products and paginate" do
    get products_path
    assert_template 'products/index'
    assert_select 'div.pagination'
    Product.paginate(page: 1, per_page: 28).each do |product|
      if product.has_stock?
        assert_select 'a[href=?]', product_path(product)
      end
    end
  end

  test "should get categorised products and paginate" do
    category = categories(:bath_bombs)
    get products_path, params: { category: category.id }
    assert_template 'products/index'
    assert_select 'div.pagination'
    category.products.paginate(page: 1, per_page: 28).each do |product|
      assert_select 'a[href=?]', product_path(product)
    end
  end
end
