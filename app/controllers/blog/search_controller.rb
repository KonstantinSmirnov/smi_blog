class Blog::SearchController < BlogController
  def index
    if params[:search_query].lstrip.chop != ''
      @found_articles = Article.published.full_text_search(params[:search_query]).paginate(:page => params[:page], :per_page => 20 )
    end

  end
end
