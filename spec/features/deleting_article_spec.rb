require 'rails_helper'

RSpec.feature 'Deleting Article' do

  before do
    @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    login_as @user
    @article = @user.articles.build(title: 'Article to be delete', body: 'I need to be deleted')
  end

  scenario 'An user delete an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content 'Article has been successfully deleted'
    expect(page.current_path).to eq articles_path
    expect(page.status_code).to eq 200
  end

end