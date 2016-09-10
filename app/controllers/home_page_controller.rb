class HomePageController < ApplicationController
  def index
    @home_page = HomePage.first
  end
end
