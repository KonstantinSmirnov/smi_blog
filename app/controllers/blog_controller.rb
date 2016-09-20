class BlogController < ApplicationController
  before_action :initialize_blog

  private

  def initialize_blog
    @categories_list = Category.all - Category.where(name: '(no category)')
  end
end
