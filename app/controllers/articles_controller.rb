class ArticlesController < ApplicationController
  def index
    @articles = Article.published.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:format])
    @article.update_attribute("views", @article.views + 1)
  end
end
