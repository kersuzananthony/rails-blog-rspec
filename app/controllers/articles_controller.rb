class ArticlesController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :same_user, only: [:edit, :update, :destroy]

  # GET '/'
  # GET '/articles'
  def index
    @articles = Article.all
  end

  # GET '/articles/:id'
  def show
    @comment = @article.comments.build
  end

  # GET '/articles/new'
  def new
    @article = Article.new
  end

  # POST '/articles'
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created'
      render 'new'
    end
  end

  # GET '/articles/:id/edit'
  def edit
  end

  # PUT '/articles/:id'
  def update
    if @article.update(article_params)
      flash[:success] = 'Article has been successfully updated'
      redirect_to article_path @article
    else
      flash.now[:danger] = 'Article has not been updated'
      render 'edit'
    end
  end

  # DELETE '/articles/:id'
  def destroy
    if @article.destroy
      flash[:success] = 'Article has been successfully deleted'
      redirect_to root_path
    end
  end

  # Private methods
  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def same_user
    if @article.user != current_user
      flash[:danger] = 'You can only edit/delete your own article.'
      redirect_to root_path
    end
  end

end
