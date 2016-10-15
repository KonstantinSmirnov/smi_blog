class BlogController < ApplicationController
  before_action :initialize_blog

  private

  def initialize_blog
    @categories_list = Category.all - Category.where(name: '(no category)')
    @tags_list = Tag.order(articles_count: :desc).limit(10)
  end
end
