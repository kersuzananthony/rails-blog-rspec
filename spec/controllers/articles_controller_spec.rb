require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    before do
      @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    end

    context 'Owner is allowed to edit his article' do
      it 'renders the edit template' do
        login_user @user
        article = Article.create(title: 'First article', body: 'Body of first article', user: @user)

        get :edit, id: article
        expect(response).to render_template :edit
      end
    end

    context 'Non owner is not allowed to edit other users articles'  do
      it 'should redirect to the root path' do
        fred = User.create!(email: 'fred@example.com', password: 'password')

        login_user fred

        article = Article.create!(title: 'Second article', body: 'Second body', user: @user)

        get :edit, id: article
        expect(response).to redirect_to root_path
        message = 'You can only edit/delete your own article.'
        expect(flash[:danger]).to eq message
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = User.create!(email: 'jon.snow@example.com', password: 'password')
    end

    context 'Owner is allowed to delete his article' do
      it 'should render the delete template' do
        login_user @user
        article = Article.create(title: 'First article', body: 'Body of first article', user: @user)

        delete :destroy, id: article
        message = 'Article has been successfully deleted'
        expect(flash[:success]).to eq message
        expect(response).to redirect_to root_path
      end
    end

    context 'Non owner is not allowed to delete other users articles'  do
      it 'should redirect to the root path' do
        fred = User.create!(email: 'fred@example.com', password: 'password')

        login_user fred

        article = Article.create!(title: 'Second article', body: 'Second body', user: @user)

        delete :destroy, id: article
        expect(response).to redirect_to root_path
        message = 'You can only edit/delete your own article.'
        expect(flash[:danger]).to eq message
      end
    end
  end

end
