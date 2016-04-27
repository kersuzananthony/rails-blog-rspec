require 'rails_helper'

RSpec.feature 'Users sign Out' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')

    visit '/'

    click_link 'Log In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'An User Sign Out' do
    visit '/'

    click_link 'Sign Out'

    expect(page).to have_content 'Signed out successfully.'
    expect(page.status_code).to eq 200
    expect(page.current_path).to eq root_path
  end

end