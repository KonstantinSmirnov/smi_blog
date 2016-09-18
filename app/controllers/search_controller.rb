class SearchController < ApplicationController
  def index
    if params[:search_query]
      @found_articles = Article.full_text_search(params[:search_query])
    end

  end
end
