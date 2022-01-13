# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

  def order_confirmation
    UserMailer.order_confirmation(User.first)
  end

  def order_dispatched
    UserMailer.order_dispatched(User.first)
  end
end
