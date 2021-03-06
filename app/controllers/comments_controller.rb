class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment has been added'
    else
      flash[:danger] = 'Comment has not been added'
    end

    redirect_to article_path @article
  end

  private
  def set_article
    @article = Article.find_by(id: params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
