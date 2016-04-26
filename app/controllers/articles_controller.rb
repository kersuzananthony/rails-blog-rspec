class ArticlesController < ApplicationController

  # GET '/'
  # GET '/articles'
  def index

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
      render 'new'
    end
  end

  # Private methods
  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

end
