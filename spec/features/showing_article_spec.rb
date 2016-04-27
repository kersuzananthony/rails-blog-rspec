require 'rails_helper'

RSpec.feature 'Showing Article' do

  before do
    @jon = User.create!(email: 'jon.snow@example.com', password: 'password')
    @fred = User.create!(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'Title of Article', body: 'Body of article', user: @jon)
  end

  scenario 'A non-signed in user can see article without delete and edit links' do
    visit '/'
    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(page.current_path).to eq article_path(@article)
    expect(page.status_code).to eq 200
    expect(page).not_to have_link 'Edit Article'
    expect(page).not_to have_link 'Delete Article'
  end

  scenario 'A non-owner signed in user can see article without delete and edit links' do
    login_as @fred

    visit '/'
    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(page.current_path).to eq article_path(@article)
    expect(page.status_code).to eq 200
    expect(page).not_to have_link 'Edit Article'
    expect(page).not_to have_link 'Delete Article'
  end

  scenario 'An owner signed in user can see article with delete and edit links' do
    login_as @jon

    visit '/'
    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(page.current_path).to eq article_path(@article)
    expect(page.status_code).to eq 200
    expect(page).to have_link 'Edit Article'
    expect(page).to have_link 'Delete Article'
  end
end