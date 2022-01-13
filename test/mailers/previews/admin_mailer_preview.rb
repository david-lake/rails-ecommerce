# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def new_order
    AdminMailer.new_order
  end

  def stock_empty
    AdminMailer.stock_empty(Product.first)
  end

  def general_message
    AdminMailer.general_message(Contact.first)
  end
end
