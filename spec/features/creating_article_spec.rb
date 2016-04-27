require 'rails_helper'

RSpec.feature 'Creating Articles' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    login_as @user
  end

  scenario 'An user creates a new article' do
    visit '/'

    click_link 'New Article'

    fill_in 'Title', with: 'Creating first article'
    fill_in 'Body', with: 'This is a body'
    click_button 'Create Article'

    expect(page).to have_content('Article has been created')
    expect(page.status_code).to eq 200
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content "Created by #{@user.email}"
  end

  scenario 'An user fails to create a new article' do
    visit '/'

    click_link 'New Article'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Create Article'

    expect(page).to have_content('Article has not been created')
    expect(page).to have_content('Title can\'t be blank')
    expect(page).to have_content('Body can\'t be blank')
  end
end