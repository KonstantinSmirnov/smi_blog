class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:format])
    @articles = @category.articles.published.order(published_on: :desc).paginate(:page => params[:page], :per_page => 10 )
  end
end
