class ArticlesController < ApplicationController
  def index
    @articles = Article.published.order(published_on: :desc).paginate(:page => params[:page], :per_page => 10 )
  end

  def show
    @article = Article.find_by(:slug => params[:id])
    @comments = @article.comments.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10 )
    @article.update_attribute("views", @article.views + 1)
    @new_comment = @article.comments.build
    cookies[:opened_article_id] = params[:id]
    cookies[:article_opened_at] = Time.now.to_i
  end
end
