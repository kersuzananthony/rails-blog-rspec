require 'rails_helper'

RSpec.feature 'Users Sign In' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
  end

  scenario 'An user sign in with valid credentials' do
    visit '/'

    click_link 'Log In'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page.status_code).to eq 200
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content "Signed in as #{@user.email}"
    expect(page.current_path).to eq root_path
  end
end