require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = Address.new(
      user: users(:lana),
      line_1: "Address line 1",
      line_2: "Address line 2",
      line_3: "Address line 3",
      town: "Town",
      county: "County",
      postcode: "SS5 9YG"
    )
  end

  test "address should be valid" do
    assert @address.valid?
  end

  test "address should be associated with a order" do
    @address.user_id = nil
    assert_not @address.valid?
  end

  test "should have line 1" do
    @address.line_1 = ""
    assert_not @address.valid?
  end

  test "should have town" do
    @address.town = ""
    assert_not @address.valid?
  end

  test "should have county" do
    @address.county = ""
    assert_not @address.valid?
  end

  test "should have postcode" do
    @address.postcode = ""
    assert_not @address.valid?
  end

  test "postcode should be valid" do
    @address.postcode = "44DD KKL"
    assert_not @address.valid?
    @address.postcode = "MM09"
    assert_not @address.valid?
    @address.postcode = "4 DD8"
    assert_not @address.valid?
  end
end
