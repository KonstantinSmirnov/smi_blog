class BlogController < ApplicationController
  before_action :initialize_blog

  private

  def initialize_blog
    @categories_list = Category.all - Category.where(name: '(no category)')
    @recent_articles = Article.published.order(published_on: :desc).limit(5)
  end
end
