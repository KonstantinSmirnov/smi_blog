class Blog::CategoriesController < BlogController

  def show
    @category = Category.find_by(:slug => params[:id])
    @articles = @category.articles.published.order(published_on: :desc).paginate(:page => params[:page], :per_page => 10 )
    @popular_articles = @category.articles.published.order(views: :desc).limit(5)
  end
end
