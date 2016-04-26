require 'rails_helper'

RSpec.feature 'Showing Article' do

  before do
    @article = Article.create(title: 'Title of Article', body: 'Body of article')
  end

  scenario 'Display individual article' do
    visit '/'
    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(page.current_path).to eq article_path(@article)
    expect(page.status_code).to eq 200
  end

end