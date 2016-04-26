class ArticlesController < ApplicationController

  before_action :set_article, only: [:show]

  # GET '/'
  # GET '/articles'
  def index
    @articles = Article.all
  end

  # GET '/articles/:id'
  def show
  end

  # GET '/articles/new'
  def new
    @article = Article.new
  end

  # POST '/articles'
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created'
      render 'new'
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

end
