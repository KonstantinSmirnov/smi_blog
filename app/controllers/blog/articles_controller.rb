class Blog::ArticlesController < BlogController
  def index
    @popular_articles = Article.published.order(views: :desc).limit(5)
    @articles = Article.published.order(published_on: :desc).paginate(:page => params[:page], :per_page => 10 )
  end

  def show
    @popular_articles = Article.published.order(views: :desc).limit(5)
    @article = Article.published.find_by(:slug => params[:id])
    @comments = @article.comments.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10 )
    @article.update_attribute("views", @article.views + 1)
    @new_comment = @article.comments.build
    cookies[:opened_article_id] = params[:id]
    cookies[:article_opened_at] = Time.now.to_i
  end
end
