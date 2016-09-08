class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :initialize_app

  private

  def initialize_app
    @social_icons_list = Social.all
    @categories_list = Category.all - Category.where(name: '(no category)')
  end
end
