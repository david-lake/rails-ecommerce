require 'rails_helper'

feature 'Login' do

  before do
    visit login_path
  end

  scenario 'standard user can login' do
    user = FactoryBot.create(:user)

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_current_path(root_path)
    expect(page).to have_link "Account"
    expect(page).to have_no_link "Manage"
  end

  scenario 'admin user can login' do
    user = FactoryBot.create(:user, admin: true)

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_current_path(root_path)
    expect(page).to have_link "Account"
    expect(page).to have_link "Manage"
  end

  scenario 'error when invalid password used' do
    user = FactoryBot.create(:user)

    fill_in "Email", with: user.email
    fill_in "Password", with: "incorrect"
    click_button "Login"

    expect(page).to have_current_path(login_path)
    expect(page).to have_no_link "Account"
    expect(find(".alert-danger").text).to eq "Invalid email or password"
  end
end
