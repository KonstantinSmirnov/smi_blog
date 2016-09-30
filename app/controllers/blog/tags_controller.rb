class Blog::TagsController < BlogController

  def show
    @tag = Tag.find_by(:slug => params[:id])
    @articles = @tag.articles.published.order(published_on: :desc).paginate(:page => params[:page], :per_page => 10 )
    @popular_articles = @tag.articles.published.order(views: :desc).limit(5)
  end
end
