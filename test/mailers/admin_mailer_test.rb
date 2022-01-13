require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "new order" do
    mail = AdminMailer.new_order
    assert_equal "New order",               mail.subject
    assert_equal ["noreply@example.com"],   mail.from
    assert_equal ["admin@companyname.com"], mail.to
  end

  test "stock empty" do
    product = products(:one)
    mail = AdminMailer.stock_empty(product)
    assert_equal "Stock empty",             mail.subject
    assert_equal ["noreply@example.com"],   mail.from
    assert_equal ["admin@companyname.com"], mail.to
    assert_match product.name,              mail.body.encoded
  end

  test "contact us message" do
    contact = contacts(:one)
    mail = AdminMailer.general_message(contact)
    assert_equal "New message from website", mail.subject
    assert_equal ["noreply@example.com"],    mail.from
    assert_equal ["admin@companyname.com"],  mail.to
    assert_match contact.name,               mail.body.encoded
    assert_match contact.email,              mail.body.encoded
    assert_match contact.message,            mail.body.encoded
  end
end
