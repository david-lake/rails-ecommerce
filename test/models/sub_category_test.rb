require 'test_helper'

class SubCategoryTest < ActiveSupport::TestCase
  def setup
    category = categories(:cards)
    @sub_cat = category.sub_categories.build(name: "Test Sub Cat")
  end

  test "should be valid" do
    assert @sub_cat.valid?
  end

  test "sub category name should be present" do
    @sub_cat.name = " "
    assert_not @sub_cat.valid?
  end

  test "should have a category id" do
    @sub_cat.category_id = nil
    assert_not @sub_cat.valid?
  end
end
