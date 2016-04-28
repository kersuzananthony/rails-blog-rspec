require 'rails_helper'

RSpec.feature 'Add Comments To Article' do

  before do
    @jon = User.create!(email: 'jon.snow@example.com', password: 'password')
    @fred = User.create!(email: 'fred.fred@example.com', password: 'password')
    login_as @jon
    @article = @jon.articles.build(title: 'This is jon\'s article', body: 'My article body')
  end

  scenario 'A signed in user can post a comment in an existing article' do
    login_as @fred

    visit '/'

    click_link @article.title
    comment = 'Jon, you are amazing!'
    fill_in 'New Comment', with: comment
    click_button 'Add Comment'

    expect(page).to have_content 'Comment has been added'
    expect(page).to have_content comment
    expect(page.current_path).to eq article_path(@article.comments.last.id)
    expect(page.status_code).to eq 200
  end

end