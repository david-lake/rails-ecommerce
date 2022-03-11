require 'rails_helper'

feature 'Login' do

  before do
    @user = FactoryBot.create(:user)
    visit login_path
  end

  scenario 'successfull' do
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Login"
    expect(page).to have_css "#account.dropdown"
  end

  scenario 'unsuccessfull' do
    fill_in "Email", with: @user.email
    fill_in "Password", with: "incorrect"
    click_button "Login"
    expect(page).to have_no_css "#account.dropdown"
    expect(find(".alert-danger").text).to eq "Invalid email or password"
  end
end
