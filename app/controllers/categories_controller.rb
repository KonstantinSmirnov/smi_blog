class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:format])
    @articles = @category.articles.published
  end
end
