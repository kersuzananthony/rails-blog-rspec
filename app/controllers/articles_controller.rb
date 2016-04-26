class ArticlesController < ApplicationController

  # GET '/'
  # GET '/articles'
  def index

  end

  def new
    @article = Article.new
  end

  def create

  end

end
