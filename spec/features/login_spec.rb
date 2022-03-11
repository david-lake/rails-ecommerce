require 'rails_helper'

feature 'Login' do

  before do
    @user = FactoryBot.create(:user)
  end

  scenario 'successfull' do
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Login"
    expect(page).to have_css "#account.dropdown"
  end
end
