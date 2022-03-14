class LoginPage < BasePage
  set_url "/login"

  element :email_field, "input[name='session[email]']"
  element :password_field, "input[name='session[password]']"

  def login(email, password)
    email_field.set(email)
    password_field.set(password)
    click_button "Login"
    HomePage.new
  end
end
