require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:david)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation",    mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.fullname,           mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:david)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset",        mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "order confirmation" do
    user = users(:david)
    mail = UserMailer.order_confirmation(user)
    assert_equal "Order confirmation",    mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
  end

  test "order dispatched" do
    user = users(:james)
    mail = UserMailer.order_dispatched(user)
    assert_equal "Order dispatched",      mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
  end
end
