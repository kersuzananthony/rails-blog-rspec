require 'rails_helper'
require 'support/macros'


RSpec.describe CommentsController, type: :controller do

  describe 'POST #create' do

    before do
      @jon = User.create!(email: 'jon.snow.2@example.com', password: 'password')
    end

    context 'Signed in user' do
      it 'should authorize the user to create a comment' do
        sign_in @jon

        article = @jon.articles.build(title: 'First article', body: 'First article')
        article.save
        post :create, :comment => { body: 'I love Game of Thrones' }, article_id: article.id

        expect(flash[:success]).to eq 'Comment has been added'
      end
    end

    context 'Non signed in user' do
      it 'should redirect to the sign in page' do
        article = Article.create(title: 'First article', body: 'First article', user: @jon)
        post :create, :comment => { body: 'I love Game of Thrones' }, article_id: article.id

        expect(response).to redirect_to new_user_session_path
      end
    end

  end

end
