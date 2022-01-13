require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    category = categories(:cards)
    sub_category = sub_categories(:birthday)
    @product = Product.new(category_id: category.id,
                           sub_category_id: sub_category.id,
                           name: "Test Product",
                           price: 2.50,
                           quantity: 20)
  end

  test "product should be valid" do
    assert @product.valid?
  end

  test "product name should be present" do
    @product.name = " "
    assert_not @product.valid?
  end

  test "product price should be present" do
    @product.price = nil
    assert_not @product.valid?
  end

  test "product price should be a decimal greater than 0, less than 100 and scale 2" do
    @product.price = 0
    assert_not @product.valid?
    @product.price = 1.2233
    assert_not @product.valid?
    @product.price = 100
    assert_not @product.valid?
  end

  test "product quantity should be present and only an integer" do
    @product.quantity = nil
    assert_not @product.valid?
    @product.quantity = 1.5
    assert_not @product.valid?
  end

  test "product should have category id" do
    @product.category_id = nil
    assert_not @product.valid?
  end

  test "product should have sub-category id" do
    @product.sub_category_id = nil
    assert_not @product.valid?
  end
end
