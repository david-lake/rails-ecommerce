require 'rails_helper'

feature 'Login' do
  let(:login_page) { LoginPage.new }

  before do
    @user = FactoryBot.create(:user)
    login_page.load
  end

  scenario 'successfull' do
    home_page = login_page.login(@user.email, @user.password)
    expect(home_page).to be_displayed
    expect(home_page).to have_account_menu
  end

  scenario 'unsuccessfull' do
    login_page.login(@user.email, "invalid")
    expect(login_page).to be_displayed
    expect(login_page).to have_no_account_menu
    expect(login_page.alert.text).to eq "Invalid email or password"
  end
end
