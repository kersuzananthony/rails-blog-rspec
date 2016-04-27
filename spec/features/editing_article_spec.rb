require 'rails_helper'

RSpec.feature 'Editing Article' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    login_as @user
    @article = @user.articles.build(title: 'First title', body: 'First body')
  end

  scenario 'An user updates an article' do
    visit '/'

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'Updated Title'
    fill_in 'Body', with: 'Updated Body'
    click_button 'Update Article'

    expect(page).to have_content 'Article has been successfully updated'
    expect(page.current_path).to eq article_path(@article)
    expect(page.status_code).to eq 200
    expect(page).to have_content 'Updated Title'
    expect(page).to have_content 'Updated Body'
  end

  scenario 'An user fails to update an article' do
    visit '/'

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Update Article'

    expect(page).to have_content 'Article has not been updated'
    expect(page.current_path).to eq article_path(@article)
    expect(page).to have_content('Title can\'t be blank')
    expect(page).to have_content('Body can\'t be blank')
  end

end