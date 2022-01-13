require 'test_helper'

class NewOrderTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lana)
  end

  test "Add new shippiing adress same billing address" do
    login_as @user
    get new_order_path
    assert_template 'orders/new'
    assert_difference 'Order.count', 1 do
      post orders_path, params: {
                          order: {
                            shipping_address_attributes: {
                               user_id: @user.id,
                               line_1: "30 Lemon Street",
                               town: "Southend",
                               county: "Essex",
                               postcode: "CM1 1AG"
                            }
                          },
                          same_billing_address: "1"
                        }
    end
    follow_redirect!
    assert_template 'orders/summary'
  end

  test "Add new shippiing address and differnet billing address" do
    login_as @user
    get new_order_path
    assert_template 'orders/new'
    assert_difference 'Order.count', 1 do
      post orders_path, params: {
                          order: {
                            shipping_address_attributes: {
                               user_id: @user.id,
                               line_1: "30 Lemon Street",
                               town: "Southend",
                               county: "Essex",
                               postcode: "SS7 9UG"
                            },
                            billing_address_attributes: {
                               user_id: @user.id,
                               line_1: "10 Lime Avenue",
                               town: "Chelmsford",
                               county: "Essex",
                               postcode: "CM1 1AG"
                            }
                          },
                          same_billing_address: "0"
                        }
    end
    follow_redirect!
    assert_template 'orders/summary'
  end

  test "Select an existing shipping address and use same billing adress" do
    login_as @user
    get new_order_path
    assert_template 'orders/new'
    assert_difference 'Order.count', 1 do
      post orders_path, params: {
                          order: { shipping_address_id: "#{@user.addresses.first.id}" },
                          same_billing_address: "1"
                        }
    end
    follow_redirect!
    assert_template 'orders/summary'
  end

  test "Select an existing shipping address and different billing address" do
    login_as @user
    get new_order_path
    assert_template 'orders/new'
    assert_difference 'Order.count', 1 do
      post orders_path, params: {
                          order: {
                            shipping_address_id: "#{@user.addresses.first.id}",
                            billing_address_id: "#{@user.addresses.last.id}"
                          },
                          same_billing_address: "0"
                        }
    end
    follow_redirect!
    assert_template 'orders/summary'
  end
end
