class ArticlesController < ApplicationController
  def index
    @articles = Article.published.order(published_on: :desc).paginate(:page => params[:page], :per_page => 10 )
  end

  def show
    @article = Article.find(params[:format])
    @article.update_attribute("views", @article.views + 1)
  end
end
