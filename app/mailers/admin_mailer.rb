class AdminMailer < ApplicationMailer
  default to: "admin@companyname.com"

  def new_order
    mail subject: "New order"
  end

  def stock_empty(product)
    @product = product
    mail subject: "Stock empty"
  end

  def general_message(contact)
    @contact = contact
    mail subject: "New message from website"
  end
end
