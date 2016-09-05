class ArticlesController < ApplicationController
  def index
    @articles = Article.published.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:format])
  end
end
